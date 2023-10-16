Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 227107CA2BD
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJLl-0000Ar-16; Mon, 16 Oct 2023 04:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJLh-00009j-OG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:53:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJLg-00023H-2d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:53:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so43066415e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697446394; x=1698051194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MTJbnYdoqXiuxKm+a4QykYC0wLWMFoq3k/gX0CMm0YM=;
 b=PSN/54I/JbSNSHBfqsmVr7BwojqRpX3a5P0RImVFt5RYFGPp7kghYS5it9RPRk4DdF
 PH422UhfiLRgwszB6t3rgzbzzin7dc+Pk1BLMhcU6delEmgp22bPxCoT55kBlgSG7N3M
 //L6oGgW8AJd3ZlWYx6CLGJMRqes3sDbaAMfcAuN8drbrAcpIDCKc5BMUOLEhYJDdaMn
 rsKBamab39rlGhMDEKX4rA/BFQ4O2kKEO732tUvlTb7l3f3GhB2OoSsO6gu85Dpxa9SM
 DDWvQD7anvhCz2o7KQDSR+VFwLtYGt9qHR5sYbxCYfDRA1QFyntUS+c2RKiL4/tA1ZkO
 i+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446394; x=1698051194;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTJbnYdoqXiuxKm+a4QykYC0wLWMFoq3k/gX0CMm0YM=;
 b=WTYk54YBaf1ISiPQX5DhqnxFi3nvYWiH5393mdqpqBOUwqN2/h36LJz90FHTr/6vJM
 b+0Yj2FhlGxWxffRilOIKU7V/DYCggKavPUntDdfhoe/HxyUhA5nUXF8srL0hdbWNufv
 9Az5GRcpIUzXRugBiCfIjCnzRJDZYuUf19E8AjIBAWn1n7MldEXn80b5hPHOO04DiulI
 7KOszIgNFMe9uJSGKX6u7sxxZJsstF3X2z3T50NL0WoxABW3twHWIOFcU95CZ8rIHip9
 CMQTdRoman0S4QTXEZjzU7NaHyO+NunqHR93bHb3J/CXRwqJCQH1ntzN+1Cw9D80Pnfp
 xvyw==
X-Gm-Message-State: AOJu0YygsDjhquxDx+t2xcoWQU2LqSwBhk2Gh7Jm1qgu9qwh3CyCff8K
 6uKES5hNCDqdQALrSwAZw2ThogdmOnTprjrDFE8=
X-Google-Smtp-Source: AGHT+IFOgLrft1qhzYaSSIEkR/oen96lsys/SwYF08irZy7OIfHY1cNHdF1YTPW0kEDeWJaxoXej7A==
X-Received: by 2002:a7b:ce09:0:b0:403:b86:f624 with SMTP id
 m9-20020a7bce09000000b004030b86f624mr28391377wmc.23.1697446394144; 
 Mon, 16 Oct 2023 01:53:14 -0700 (PDT)
Received: from meli.delivery (ppp-2-87-17-65.home.otenet.gr. [2.87.17.65])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c1d8a00b003fe23b10fdfsm6551053wms.36.2023.10.16.01.53.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:53:13 -0700 (PDT)
Date: Mon, 16 Oct 2023 11:45:08 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
User-Agent: meli 0.8.2
References: <20231016083201.23736-1-hreitz@redhat.com>
In-Reply-To: <20231016083201.23736-1-hreitz@redhat.com>
Message-ID: <2m60m.9e9wlnnm01vd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
>diff --git a/include/hw/virtio/vhost-user.h 
>b/include/hw/virtio/vhost-user.h
>index 9f9ddf878d..1d4121431b 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>     VHOST_USER_PROTOCOL_F_STATUS = 16,
>-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>     VHOST_USER_PROTOCOL_F_MAX
> };

May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well instead 
of a comment mention?

Otherwise:

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

