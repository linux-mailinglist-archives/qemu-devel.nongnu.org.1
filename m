Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8627B7AFF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXT-0001wZ-4G; Wed, 04 Oct 2023 04:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxW6-0008Pn-6j
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxW4-0002Ph-Dj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc0LwezzCtuJZwfRfwd6fEilbxVEAWIE8I0MI4RifxI=;
 b=iF4AXAOqzV4y4PdQ1FFdblOI8ljEKuTEGqZZ9UM5VvKxxcM6CIafV2QomFADpYdcu3I/PN
 +JJ2a9VpvZgHMYDudVPhT0Alu/IOk43u3C2RGVDGd67KfybMUkM4+o+pKCC+hxD9DrCsOi
 Vf7gtBul87KOUFFaKG1MjUIJV0KoCQw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-9-ydC1q6PpCVzvXdJ0Qf2A-1; Wed, 04 Oct 2023 04:45:58 -0400
X-MC-Unique: 9-ydC1q6PpCVzvXdJ0Qf2A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso14738125e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409156; x=1697013956;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc0LwezzCtuJZwfRfwd6fEilbxVEAWIE8I0MI4RifxI=;
 b=Div9GCzhYYoWDTmUJGslvixZGENBsFR8oOn6Oy6EJ4V+5HQYeznBjUlpA3+T0YdF3N
 0MPLCRa/WUeSEJWpju7fmlv6aydlh9WFEd7+KQn8XzPdkNloBmSklfKwmR65+QoVbKLI
 uPJ0iCYlWW68jqFbTmwlt8AKeEB88gNj3CGOrhO1UT/6WZjp8aOrHU/6Shotu3RE1tmA
 iCkNUfeJQasV66eeXxgW1SDrEvhDnlKDcriATi+ifR2xQ/0iYpXHdEgZNr7KWP1wtRKz
 RVarRFRfLIXjnEzK55e2qFJ6H8uyj1KrXvGIzuffoD4VK3Y+POk1G2R0ZDwvm48qrmnu
 zfEA==
X-Gm-Message-State: AOJu0Yy1WNxcQMsRJ9TuIu07kkrWFdk5aUfXdZH+Pp70Jt2t65KLaxhT
 QDiNOqZAH4VJR6yUIuf6S/CStPPiSnNKT83YQb1j+V69UiO9tE0a9Bjivr8Va/gIpiZ3O56U7+1
 g5XroQksYGhATUhab80Q84FZGxNg0VTTA/FFW51JDTl0x2dOop7x6CCXunHqN95qyENEf
X-Received: by 2002:adf:de09:0:b0:317:e515:d623 with SMTP id
 b9-20020adfde09000000b00317e515d623mr1507104wrm.60.1696409156657; 
 Wed, 04 Oct 2023 01:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSXv8LpebvWumM4x4vMBaUxO1fpxzAwEgJlFBAv31mu3UL0zYcn58XGR1MJoBBusEQAlT+Q==
X-Received: by 2002:adf:de09:0:b0:317:e515:d623 with SMTP id
 b9-20020adfde09000000b00317e515d623mr1507087wrm.60.1696409156375; 
 Wed, 04 Oct 2023 01:45:56 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00318147fd2d3sm3469330wru.41.2023.10.04.01.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:55 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 51/63] vdpa net: stop probing if cannot set features
Message-ID: <a063893b1c2f72b8fb8e331a526b9464adec3746.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

Otherwise it continues the CVQ isolation probing.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-3-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 650125bb0f..b688877f90 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1364,6 +1364,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
     if (unlikely(r)) {
         error_setg_errno(errp, errno, "Cannot set features");
+        goto out;
     }
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
-- 
MST


