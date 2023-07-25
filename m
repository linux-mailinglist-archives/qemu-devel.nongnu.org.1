Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C765B7614F0
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOG8a-00070z-Ig; Tue, 25 Jul 2023 07:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashutosh.dandora4@gmail.com>)
 id 1qOG8R-0006xM-BV
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:23:23 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ashutosh.dandora4@gmail.com>)
 id 1qOG8P-0004Xt-S5
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:23:23 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a5ad21a1f9so1430614b6e.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690284200; x=1690889000;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aoryWTbp1RwQbuqaq/2y7j5Mq/riE7DEfUYcDoVaMAo=;
 b=FOYRNeqcBewc1b9xwrcN2Fbie0kSwkExH9avBuCAOI7xTLGwf1cqpl/8tNo3kTBHCQ
 O5G2oi6/8XHIjkzU6/iY2nVlgbYNGVMRurDy/6KXnB/u6abQco4/Uujk6OVjRRw6hMw2
 ONgSEMrYU3Te5mihSOQxYw/u4GlHPeJFt3UNW8Aw7PF/O3od21wYBekNPaPfX0GAHHia
 qH2KgVVT8q8v6bklJAePBBhMba3fvjmFue1ZQz7pPtEtpzDSO+A9eZwL1ZMs/JTV3mQ1
 JzRxiZ1rviQ6atWWad0CIRumOs5fqyaXRexhO3bOc7idcupzk8cRWafI1IJHpOulkl3y
 kywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690284200; x=1690889000;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aoryWTbp1RwQbuqaq/2y7j5Mq/riE7DEfUYcDoVaMAo=;
 b=h2BnAPsZPXpdma7WeZenC/HQl5KUzPsSWCmDvrjFQBLHzFX6oPCjyFaTeGOSQIdIgd
 m6z0e8tHVxxmTywI2TlB/kiadC1O0Uc0Eibj/4oOIZ80dWSzN8zNVvTE59S2Mwz3jmoo
 b2HasR+a8DhevL8hJrQGYAAjedEW1oTdFko8nkuRbxEiNVmEKPDGxtDLGL//vFSaDtod
 AE8B7x3oPjmY1FOtwq6n1bHpf5Br4SRiYg34SVeosnc8A7jOVxBMmb0Eza/dHDfUy4/9
 wESqHWVMxevXzfTqkfNgACLIX5AvkI0XUgIABV48i0FntUd/1GB4PR/vjtgELPyzjx83
 FEuw==
X-Gm-Message-State: ABy/qLZEiOA0N3qzaPDUITLyFzRPNnYidhArqm6vV3WbbftPI4wh3Jv8
 pg7lYKy+zUocKQ88/fQLGL+ppltyiSZXIkDF+vlrTuIi
X-Google-Smtp-Source: APBJJlG0aPUVHxJepyrythEMoI8T92TsWne9i4dL2wx6wdA3QNX1wEDNbMd7QIgBTJzXHK6JuBh6XA9MCtkgIKFkGnk=
X-Received: by 2002:a05:6808:ecc:b0:3a4:24c5:ff14 with SMTP id
 q12-20020a0568080ecc00b003a424c5ff14mr15769742oiv.4.1690284200020; Tue, 25
 Jul 2023 04:23:20 -0700 (PDT)
MIME-Version: 1.0
From: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Date: Tue, 25 Jul 2023 16:53:09 +0530
Message-ID: <CADOvtemuUgp322fE6xYrzVp_RNU_jpqOfzd-12ES-jpPoDvBaA@mail.gmail.com>
Subject: Format type of qemu NVMe virtual drive reverted back to its default
 (512 bytes block size) after performing hot plugout/plugin operation on that
 drive.
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, k.jensen@samsung.com, philmd@linaro.org, 
 armbru@redhat.com, mst@redhat.com, lukasz.gieryk@linux.intel.com, 
 alex.williamson@redhat.com, helgaas@kernel.org, afaria@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ashutosh.dandora4@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

I have a virtual system created using qemu 7.2. In that system, I
attached/hot plugged a virtual NVMe drive. This drive had a default
block size of 512 bytes.

admin@node-3:~$ sudo nvme list
Node                  SN                   Model
             Namespace Usage                      Format           FW
Rev
--------------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
             1          34.36  GB /  34.36  GB    512   B +  0 B
7.1.92

After that, I formatted this drive with 4k block size and it formatted
successfully.

admin@node-3:~$ sudo nvme format /dev/nvme0n1 -f --lbaf 4
Success formatting namespace:1
admin@node-3:~$
admin@node-3:~$ sudo nvme list
Node                  SN                   Model
             Namespace Usage                      Format           FW
Rev
--------------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
             1          34.36  GB /  34.36  GB      4 KiB +  0 B
7.1.92

Then, I just performed the hot plugout and then plugin operation on
that drive using qmp.execute's device_del and device_add cmd
respectively.

But, after that, the default block size of that drive reverted to 512 bytes.

admin@node-3:~$ sudo nvme list
Node                  SN                   Model
             Namespace Usage                      Format           FW
Rev
--------------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
             1          34.36  GB /  34.36  GB    512   B +  0 B
7.1.92

So, I just wanted to know why the NVMe format type reverted back to
512 bytes, as I just performed the hot plugout/plugin operations only.
Drive's block size (format type) should not be changed upon
removal/insertion, right ? or am I missing something ?

Regards,
Ashutosh

