Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F091772189
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyJE-0000fW-Vp; Mon, 07 Aug 2023 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSyJC-0000fN-UR
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSyJB-0000Kr-5G
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691407315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ac9SFrhrn5JnsN2vIpLZMPG8If4PmhWNMII1pwtuLvMyI9ZUmoMZHBgP6ApwoulkFXFMC3
 soNuYps8Kq8mndtaEnFGYGNNEO6SBTrM27KD9Kv3WoDryb0zg1LjHAnhabnS9Dmh/WZ7tl
 GJ2iXSNrUPA2RTMhdGIsqt9lHkIy1n8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-oP76T_jGMn-FMDvVUVCHvA-1; Mon, 07 Aug 2023 07:21:54 -0400
X-MC-Unique: oP76T_jGMn-FMDvVUVCHvA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9c548bc66so41446641fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 04:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691407312; x=1692012112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=bP5XGZf3TFvdC2oe0Z2TVsMSqMaJit44ES8fpqq+54vKJWc3TkJpfhcVT9rYaj8PA0
 fLn1FyMrd+KPOa2xs87oaL/yQ4rjlcpRNqqZrfbKqOecm9LIwO6bpesJVQmicBjb3HTP
 2WhI42SQcDbpnrSa4hFdyd9SXkFrElKIqs6aUz0zmbWtHzUV3L6u3FdshtOz4tiYtHTK
 MhuVdcZ35chcY0dQ2QW/ujwngUg9Hf0j9WhBVh6pB0v+P2srpCRrDS7Dl/tokNq9uwbG
 kZWTahj33HkGgOZUIBrsn1ZIUWn/ldvysozL3DwKJ+pVRNj0d2BqEY30aQ1P/UZIAWyj
 ELkg==
X-Gm-Message-State: AOJu0YxQcScVCysSULrtT6frChGLt53oEchdBAbeK56GPopioXy92IBu
 HpcGsU214zd/FzeOxZcFjMAgAKSsMkDwwcYi9djjSFPRRdpulgpvNdjRUtDVgJiEojx/LZAYufQ
 8ltAM3KiIOC+fhZs=
X-Received: by 2002:a2e:94c2:0:b0:2b8:4079:fd9d with SMTP id
 r2-20020a2e94c2000000b002b84079fd9dmr5929383ljh.29.1691407312726; 
 Mon, 07 Aug 2023 04:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEandWI0i9FZ1YsDz67QlgburGBEWfhjLFkEm6Cw6otyweL6V2HCvJG7i0PASQU0TTSR/Nr1w==
X-Received: by 2002:a2e:94c2:0:b0:2b8:4079:fd9d with SMTP id
 r2-20020a2e94c2000000b002b84079fd9dmr5929374ljh.29.1691407312366; 
 Mon, 07 Aug 2023 04:21:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 h6-20020adffd46000000b00317878d83c6sm10178208wrs.72.2023.08.07.04.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 04:21:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ake Koomsin <ake@igel.co.jp>
Cc: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] targer/i386: add support for
 VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
Date: Mon,  7 Aug 2023 13:21:49 +0200
Message-ID: <20230807112149.479931-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807093339.32091-2-ake@igel.co.jp>
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
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


