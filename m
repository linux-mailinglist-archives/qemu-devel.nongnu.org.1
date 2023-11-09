Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 876067E704F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:31:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18s5-0005zr-2r; Thu, 09 Nov 2023 12:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18rY-0005we-57
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18rT-0001zO-MZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SdtKFa7mxprOYlxBZB3ggTFL38OA4DGj0DEz1vwno+0MS2sdmSVplyDuG3Rqh3nG5/mHmQ
 SFX6Yao1FzhLFasuUVusDXnGSOBE3w4gNNi695X3P6VkXR/3m8zkgcQ59Jw/dYThZ11LQr
 0vD6x2+tXS4Zta1Xc6/i7//NkYPiyeI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345--WW-LRkZNFiKNqI_VzYy5g-1; Thu, 09 Nov 2023 12:30:29 -0500
X-MC-Unique: -WW-LRkZNFiKNqI_VzYy5g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e2acda9d6so947779a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699551027; x=1700155827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nApn3V08rXTUknJS8iFPZpA9FCIBMwTnx7Eb2JI/BnVkKJ9GUpso69bYEgJrMlVPsy
 lfRTxa9FOrwLFGAU81ssNf6nen13QeuARVqRyNspCgV/K45VuifQ/YkHRO5seuo8y3qf
 b4cQIk6M9JGgvLPl8GgRtdwfwdymAoSessLRKlEb/2JqZOrnrN1TBngZhMQisCFrzFOx
 N+tlqJB50108xwLVFU1zIGIAKE1gDz4sq0ADhhYTke4WO2VYBpYgcL11OY1krRTkv/Gr
 S5hpAAWdJpUokwDHi1ZIQL8o9g4dr1gk5KO0ARnLMkrbuoKnMaygDkhdAjPUd/8AicPH
 AYQQ==
X-Gm-Message-State: AOJu0YwTdf+CO/JrDm16TbmaJCgxaMg29YctgPrFApmTDNQPV/UvLDdc
 DeMfTjRt3c+JXh/00vIX54sc//uIcSfy5EJ1uqb6otOiUuPy+SwHSJ49HuJ8QWAeFvjbgLDVUas
 AwS3comRx599kb0M=
X-Received: by 2002:a50:9994:0:b0:540:b1fb:b630 with SMTP id
 m20-20020a509994000000b00540b1fbb630mr4688600edb.27.1699551027400; 
 Thu, 09 Nov 2023 09:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOPUGtGIlHZgYEDICnWj3JtfnKb1LwKB2SB50zRUkhwalAcFo0MBiTaPo8zt22/6IyIvIdfA==
X-Received: by 2002:a50:9994:0:b0:540:b1fb:b630 with SMTP id
 m20-20020a509994000000b00540b1fbb630mr4688581edb.27.1699551027095; 
 Thu, 09 Nov 2023 09:30:27 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a50aad9000000b00540e894609dsm75606edc.17.2023.11.09.09.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 09:30:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
Date: Thu,  9 Nov 2023 18:30:21 +0100
Message-ID: <20231109173021.851946-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108162022.76189-1-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Queued, thanks.

Paolo


