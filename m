Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59FD71655F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40mh-00064B-Gi; Tue, 30 May 2023 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q40mc-0005tQ-7o
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q40ma-0001f0-LK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685458627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BzZRWiJ77ZlvOoqEBNU6Ha8tPKYDRfrzUAVzUGm9AkyJAgHr5JoStBTePYTMSyCJrCheza
 npHewYT08jhZyv17FxEiaFTwXRqceSqIjhOwKDDtc1U+ZXjesye8iK8p0HLC6dY6H3JZ38
 c8S95n+M/snCrXdkSHN76+iw8WzPqV4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-h1_qKZEANqq-E4zKIVLqyQ-1; Tue, 30 May 2023 10:57:05 -0400
X-MC-Unique: h1_qKZEANqq-E4zKIVLqyQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-514559574a9so5157902a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458624; x=1688050624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Oyz0SkR5DC364uCx6fYpV9fXZ7342Y60xOGpA5qgLct36QJsb2lBobOoihLOZHE7+d
 IrAma6OO2PmwiF4T+QNLlMKE3DW1j6jfdr8MKInG8NFSMm/dpprNjKXpanu1EQu1+P/6
 WzSE7V6lvKJTbdfrRmxewjl+n0/+pVS1lv0OEraRX8qB4+BKX2WyriSSgVMK4HXzmkGj
 8yMf4W3zvBLeMc41o3dC97PJh/uKBnmOU0URD614Ifl4QxMWbBVbeBsTUTPrQ46UULWE
 c/4gNqLjjabFAp6wgIHyfK0l7GzH5UXbtCB+ceqkqM7+lJhroI4+S1YQrvpef1wl0oei
 PLzA==
X-Gm-Message-State: AC+VfDznrz38hWj/o0U1sWQzs6M2U1z5+mRnyhdczzNLTbTOVLwYWBGS
 j8OEOOPGLDV4DA0ph3VOXpGWggtXnGpIiHQd5O92brzQSLTJcG79aDayHhQ5PZcI4iC+m5AAF5W
 2oXHsKVarDGCTA6DpQAivUGU=
X-Received: by 2002:a05:6402:4308:b0:514:5595:69b3 with SMTP id
 m8-20020a056402430800b00514559569b3mr3401469edc.4.1685458624072; 
 Tue, 30 May 2023 07:57:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66M44ynha8OImeQphnVgJjlUA7MTsDAYjlkV5ke/FLNbCBx4t5eYskB26EpZ0RuJxJ13vh/A==
X-Received: by 2002:a05:6402:4308:b0:514:5595:69b3 with SMTP id
 m8-20020a056402430800b00514559569b3mr3401455edc.4.1685458623818; 
 Tue, 30 May 2023 07:57:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a056402230200b00510d110db58sm4395863eda.80.2023.05.30.07.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 07:57:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] meson: Avoid implicit declaration of functions
Date: Tue, 30 May 2023 16:57:01 +0200
Message-Id: <20230530145701.90169-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8e02776d18595a1c575c90a189ff65f1785f76ca.1685442612.git.mprivozn@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


