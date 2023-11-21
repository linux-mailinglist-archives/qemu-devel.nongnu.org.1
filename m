Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81517F32B3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:51:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T1O-0007aA-4B; Tue, 21 Nov 2023 10:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T1B-0007TA-UF
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T0q-0001Bs-Po
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700581807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PrE/UpANnZFqxhLxkRfXmsCKTakSpx5Q1ga51s9GuhQw0d9mGo3jLUbYPU3z5WdWp3YtKw
 m4XjvaD4iChZqtoAp7DIdcwYh5JUVL0K9VexRs8vr7XkTw1alsq7R3a/kRgry+L5Pl5G3V
 /kNbKrBq2oLWluO8DXv+bESAqcYJHnA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-cLq4bj9LPd2lBv7Qd8RxTw-1; Tue, 21 Nov 2023 10:50:06 -0500
X-MC-Unique: cLq4bj9LPd2lBv7Qd8RxTw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-778b5445527so1337621285a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700581805; x=1701186605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=J1Zk7PIC3thxXq05lAf+srJrqYuRkzvcxd0c2LGR88IZUgFKl/BrT0Sjk1YU/Fi+tn
 ve8ui0AG/seluQm/u7p9Lil+yP478wONyVV3FsL2vvUGrV65eusJR8JfdeDzLrhTSBVQ
 sM0ftia8vWYPzObAgvLJ9gsrcLqJ4Xa7HPkHd1VlVpQ8v+ocKPYwk5aZqxLnEgME00Et
 oYIyAedJcITrqXGtjk+bnJBvwIpCNacfJTNqEsW2sFkCFxxLjCf1+Spo7JfXItLYueoG
 k8w1YGBcnZV3c8sbAKlehcc3HJtbucSyQL9D0qiIDEmEgIfJRGV6JU0k9dgFiao5A0D/
 S8Dg==
X-Gm-Message-State: AOJu0YyZ8QoPJ1OIR9GzBQHsEFIobVbV3VtZ4FbXlP2X/4PG0cGmrJV2
 cRaIUyL4zNqVxfu8AM5t8S2pkLge1OMIEGlqWERJgWNj73o+s0OV2m6XBWjNOHDZZY1xx2UwAnX
 Lpuuv/yu4T7/cXlk=
X-Received: by 2002:a05:620a:44c8:b0:778:8ebc:129f with SMTP id
 y8-20020a05620a44c800b007788ebc129fmr4671280qkp.8.1700581805749; 
 Tue, 21 Nov 2023 07:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWP+i9wtvPFAZFbjPhm1FuIyrvMp4sXo2Fwbr+3nLeReeQvjkm1dbCSDGMZ1/YihCMkRVLow==
X-Received: by 2002:a05:620a:44c8:b0:778:8ebc:129f with SMTP id
 y8-20020a05620a44c800b007788ebc129fmr4671256qkp.8.1700581805503; 
 Tue, 21 Nov 2023 07:50:05 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 sn1-20020a05620a948100b00770f2a690a8sm3725698qkn.53.2023.11.21.07.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:50:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] system: Use &error_abort in
 memory_region_init_ram_[device_]ptr()
Date: Tue, 21 Nov 2023 16:49:59 +0100
Message-ID: <20231121155001.32588-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120133112.82447-1-philmd@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001,
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


