Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611C7CE262
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:11:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vN-0006GB-J1; Wed, 18 Oct 2023 11:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uS-00045b-If
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uR-00075X-7c
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=gwDvjT92WIYKWi5DvilI2JT5r2qjEhEOE1s7Niq0ywA22hCdea9Z1rNQKVVYRPgVdyPrCB
 dfn9P4gpyg3RCh0aYBHBv4ncASVGCIarYLWO0FUDlVBCSlJ/lXyzrS8hG5ieK3MwxgSvm2
 PnUTluKzoS8U0frU3HFgTAGchyCYfw4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-sMkx8DoaPSGTItzatujwOA-1; Wed, 18 Oct 2023 11:56:33 -0400
X-MC-Unique: sMkx8DoaPSGTItzatujwOA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c5032ab59eso56462981fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644591; x=1698249391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=Py+y2QvUDTCY9KsVs1c2QxAFmyhyZ3ZW1Uws8HK6NdDlaK3XqnyoYLCoNa6NMQzYHz
 TYQNTls8/xqq0PUbwGV2o4xdsRReGhDe0Egd1+CRwCUqGJN0JmuJZpHRRIxnSP9yZctx
 LXZKJQSJEh9UK2BvHdecCLfJCQbKdDZRQqXz9Y6I0SgEtLsTbcAIRejMBRBNlTZjOIB2
 BVb7PGdEF+46A8EDEGXrH5bK2Z7evlVf3+WGZMdV2dfmPaO50BSiWv5Gkgavg+H5UgzW
 TocCfv4MUSu8h6NzqYG/ltTPUY3ExDQ6Gy3mw/mrSsYBV0WKHVWmWLxgJr5X/TlA7eRq
 CkvA==
X-Gm-Message-State: AOJu0YwelINCXLC9oEl+1ZelD3a/DTAj7IgU+19uT0VnwyaCbDdEo+42
 pWPMYdm4/qeeoCD+vSDawWnK/cNLP11606KZpykEghKvxszWpeh4NwP5ckLk5eyuNXye2/FP0Ty
 3weN9kvrgT2X6Hs+9ncS26JeXEDyIqb8ycDQ633lbbnxc75B+XuWPR7wKWolWrnZphnN5Vz8=
X-Received: by 2002:a2e:a54d:0:b0:2c5:1b02:2d37 with SMTP id
 e13-20020a2ea54d000000b002c51b022d37mr2551014ljn.6.1697644591054; 
 Wed, 18 Oct 2023 08:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGTmI8xfFMaIrBeh9By0cjzp+MK7nNx5lcT33F3Gvw64c6mpbYgCT3yae6aZSP6SPfp86u/w==
X-Received: by 2002:a2e:a54d:0:b0:2c5:1b02:2d37 with SMTP id
 e13-20020a2ea54d000000b002c51b022d37mr2550996ljn.6.1697644590741; 
 Wed, 18 Oct 2023 08:56:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c0a0400b0040775501256sm2033331wmp.16.2023.10.18.08.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Damien Zammit <damien@zamaudio.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 41/83] timer/i8254: Fix one shot PIT mode
Message-ID: <83def49ca026a1707f4923266280b14c766a5bc3.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Damien Zammit <damien@zamaudio.com>

Currently, the one-shot (mode 1) PIT expires far too quickly,
due to the output being set under the wrong logic.
This change fixes the one-shot PIT mode to behave similarly to mode 0.

TESTED: using the one-shot PIT mode to calibrate a local apic timer.

Signed-off-by: Damien Zammit <damien@zamaudio.com>

Message-Id: <20230226015755.52624-1-damien@zamaudio.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/timer/i8254_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index e4093e2904..b25da448c8 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -52,10 +52,8 @@ int pit_get_out(PITChannelState *s, int64_t current_time)
     switch (s->mode) {
     default:
     case 0:
-        out = (d >= s->count);
-        break;
     case 1:
-        out = (d < s->count);
+        out = (d >= s->count);
         break;
     case 2:
         if ((d % s->count) == 0 && d != 0) {
-- 
MST


