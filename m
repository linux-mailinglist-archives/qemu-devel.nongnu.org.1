Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9067BD3FF
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkGr-0003PX-4C; Mon, 09 Oct 2023 03:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpkGp-0003PL-42
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpkGn-0000wN-QN
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696834896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gMsAuDMl3niX7Jp0Ag/zaN4+FH90bBOakztt7TMmJ3K1O4F+S8ZLKfU9LE5wfPncShUpdt
 El/kxms43xKw9vqSSbds1I1QZOe1cdU7CsvZhCpLeAtEiT3tHZffkEZ2rrtgc6Vzg3VEd9
 FDUkEbRht5iFJCOn6gEEOBDuMIqt+og=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-6W-rGGWYOpmjXxShwtSOCQ-1; Mon, 09 Oct 2023 03:01:24 -0400
X-MC-Unique: 6W-rGGWYOpmjXxShwtSOCQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-327b5f2235aso3059300f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696834883; x=1697439683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=wAVH9pEoF+4lR/XerN4QbufUcPemcjq4L05PWPYL06BAm3uuy3KHMD5PDIqenSdU5L
 GWYrq2uYySVUIomwuQdJUD8DX1yC3NfX/N9q5M0T26HE7u5pauI03orJXHfqFByJGahO
 FvCOC0TpfSv/Hy9VKm2slTUYMnhhefzoiKqn1bVs3VQUdHkv4YNWcoBaXle0cEdWyVuo
 ceofGYKDSD4uDtm+vopjNzN1y3elDCZxGw3JFfErIOKodETPeLxOtlWekM1xrk8UKt97
 ESMBLoJ0xqoXIEu6ZIlZAZg2r1MFmEyXKGSAgap6k2YNJjnEsIH1zkXOZVoQ7nviZXVZ
 USyw==
X-Gm-Message-State: AOJu0YyBb1Co+OrSEMtOfDmPQi03f3rkijRsKZOiNo1H/Evk8VgzXmsL
 7+bSz6V3KQNXd+EANoyxXrWmINMDSk50W37UvpqUhZiOS/mkIxRZLXLwnWiqQFHBgYC04QUb/ye
 72gEafnYxn5k6sJI=
X-Received: by 2002:adf:f084:0:b0:314:a3f:9c08 with SMTP id
 n4-20020adff084000000b003140a3f9c08mr11869741wro.39.1696834883661; 
 Mon, 09 Oct 2023 00:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXBPDB+J1eCaJaqctAUYZlSJvlamzFFkwmxZnEThZ+vv6X4SqaYnQAgqAx7XF5CmKW0/ZBsQ==
X-Received: by 2002:adf:f084:0:b0:314:a3f:9c08 with SMTP id
 n4-20020adff084000000b003140a3f9c08mr11869725wro.39.1696834883335; 
 Mon, 09 Oct 2023 00:01:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adfcd89000000b00317f70240afsm8573828wrj.27.2023.10.09.00.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 00:01:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] scripts/xml-preprocess: Make sure this script is invoked
 via the right Python
Date: Mon,  9 Oct 2023 09:01:21 +0200
Message-ID: <20231009070121.74177-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006045256.395696-1-thuth@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


