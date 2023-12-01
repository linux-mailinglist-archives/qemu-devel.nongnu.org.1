Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9EA8010FE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:18:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977R-00034m-Jb; Fri, 01 Dec 2023 12:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9775-0002uP-8I
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9773-0007iy-GV
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znpeHFsqvt7sT7Zklp3710sxh+39axJz6ji7vrYCX/M=;
 b=QQsV36OSofI3fZHtidqcNtgQ0IbizwdMQZDSrWG88juXFnLhVFgX9CqFBM5zc3XTZSIf+s
 VXxWXsUws6yJmnk4Fh3/q+Wi+6meiM6ykeEZWIZsciNc4V3p6MV8QQ7ip71NOtsyTwVeE6
 Zt7r6fzsY+hQqwRtlGLAR/iUYuIDDik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-iEnzmYwUNve8SMJCeeig2Q-1; Fri, 01 Dec 2023 12:15:35 -0500
X-MC-Unique: iEnzmYwUNve8SMJCeeig2Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b3d4d6417so15768605e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450933; x=1702055733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znpeHFsqvt7sT7Zklp3710sxh+39axJz6ji7vrYCX/M=;
 b=Trk8EfeFCdYD73RLyTypcZcC+KqWTPnYrKjbSIH+hVc8auPyp3kGCJFuqqvI8RPoFa
 5jGerfKNxXArFe+78QU5dV1hhgHTOq7oUDn9df1mMGlDNPyIGHNKLyxfGDwQH89W8H9j
 CYqhVYbHih6gE4rit5sR57Y4ae6fw3o7ZTFYJ0pkZsi2us7VCgZSe7mKbze7AqQyYz0C
 KiNiJKkpLbS6GG7n9UNjEelk6J/46E5faO29PefqqZ8yrGe1TPDexa08Ej/Lv4GxqVBy
 Aa3daMir1JPGQbra08fRXe7xWuKRjgYvXma0E5pFX5Oak+Ii2F8TvRIbyLkz4R8+aCYN
 Ntug==
X-Gm-Message-State: AOJu0YzYm1YMoOaYYfBETh1fcbVKcZbVBo2PNNIL6HqSbgeiTAHi3V+t
 T0mAi1x8ycHWiEN63cztnNTX8Mhv+4ZzELlkFw47/3Lq2THm7i3JceBZTZU68Dv67/VoXu4Frmf
 J5yQ7RkR0xg0c7wi+PAe2+QQBrkchphGjzw6Q0p37c7rfB/hMRAohG0K5eG6zDjvyrCGR
X-Received: by 2002:a7b:c3c7:0:b0:40b:5e1c:2fad with SMTP id
 t7-20020a7bc3c7000000b0040b5e1c2fadmr299602wmj.61.1701450933637; 
 Fri, 01 Dec 2023 09:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMNdq4cEkZmi9PsbMLa2LZs24rdXqvsrVDMtEXRp+wZVSJ3op76pLirQl3SRjiM4eiIk4eYg==
X-Received: by 2002:a7b:c3c7:0:b0:40b:5e1c:2fad with SMTP id
 t7-20020a7bc3c7000000b0040b5e1c2fadmr299590wmj.61.1701450933318; 
 Fri, 01 Dec 2023 09:15:33 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with UTF8SMTPSA id
 fs16-20020a05600c3f9000b0040b48690c49sm5977597wmb.6.2023.12.01.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:32 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	Yanghang Liu <yanghliu@redhat.com>, Cédric@redhat.com,
	Le@redhat.com, Goater@redhat.com, &lt@redhat.com,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/15] pcie_sriov: Remove g_new assertion
Message-ID: <8732d9640349c834c41e26d188fbaf6dc923f3ad.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

g_new() aborts if the allocation fails so it returns NULL only if the
requested allocation size is zero. register_vfs() makes such an
allocation if NumVFs is zero so it should not assert that g_new()
returns a non-NULL value.

Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Buglink: https://issues.redhat.com/browse/RHEL-17209
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231123075630.12057-1-akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Yanghang Liu<yanghliu@redhat.com>
Reviewed-by: Cédric Le Goater &lt;<a href="mailto:clg@redhat.com" target="_blank">clg@redhat.com</a>&gt;<br>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 5ef8950940..a1fe65f5d8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
-    assert(dev->exp.sriov_pf.vf);
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
-- 
MST


