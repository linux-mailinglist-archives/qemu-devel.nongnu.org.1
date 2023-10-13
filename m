Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075897C8036
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6P-0002zg-Fz; Fri, 13 Oct 2023 04:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5e-0008F7-PL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5b-0007Xe-SQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so19266045e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184005; x=1697788805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Zrcq9ApjaSiX+ErhH5YDa/34snZZueP1MDiY19ihlA=;
 b=ihNhlMuORqAVK04mbaqMULOhKkwrHqQKGDmp+NynLjot2dnVcvcrRAL5TaffrIr9tQ
 1NFKL89lUADvic3XKYMQK5GToeWdJVOMMIlJxPs5SGFEcoOqECSIJtZLxpqycpt/dKUU
 DJgsucxiDmcdEdjbHHnmpVGELZCZac5XFIcDMtXXc6hPJKkgSfff14YUYPa2Q1lxtgEf
 gW/jGToV1YWZbHRLCo/oX01LPpAIS4esMdQhnD9OoKDq37HxR0RF8XhhruVNIebGr1/C
 XVNaRQY7z7D4cIh8Bnty6TY/anSkaRKjPF3HhYjAN6u392RSptCNruibJNVadMbKQ0Tf
 3i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184005; x=1697788805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Zrcq9ApjaSiX+ErhH5YDa/34snZZueP1MDiY19ihlA=;
 b=hlAl9ysLJ10pOEDvqS3OzttvQbtMpMrxsQ2qQSuz367ZI0Xze0HVmsujSxV9TEdx2l
 yTB8nnluWqiRWQ759W+KeCQHDRriz41+VeNuce0vejZKv+xuDKrewaCgaWYauNlYRq/J
 LNLyH2nbQbjXAMVj3cDF4k/vcch0a3iR3ws+HU6EedAWMHyrOppn4T4Fht8MggMHbBTn
 WcilPy75YeJPX0coQO3K7rQessqDE6gTCyBiI2YMuD4NmyHrs7MzUWypbMTOe7WKujp8
 dT4IHVNqm4BXBZNBc3iKzih+hVG75L1lDeCEDX7la5Fo7EAfJNnDK5XEzOhIPagY/wg3
 yF7w==
X-Gm-Message-State: AOJu0YzzIOlJhUs5m+3/5RlFL1kdl5OriX12xw0FjTCRlAK2tJzkfqW+
 OroRbOH1hZVK+uuHYj2gFSG7t9ViWGGjZ57UVaM=
X-Google-Smtp-Source: AGHT+IFwrbt9HknJ9aS/y+QQ+CgYHkrYmMOmDeg4iu8d+oXqkm4jaqCeL36SKEg0779i3pRUQudApQ==
X-Received: by 2002:a05:600c:11cf:b0:405:7400:1e42 with SMTP id
 b15-20020a05600c11cf00b0040574001e42mr23382367wmi.41.1697184005378; 
 Fri, 13 Oct 2023 01:00:05 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:04 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390-ccw boot)
Subject: [RFC PATCH v2 71/78] hw/s390x: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:38 +0300
Message-Id: <027ebef63f822f425c496a49112b38a62305b3e5.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/s390x/ipl.c           | 1 +
 hw/s390x/s390-pci-inst.c | 4 ++--
 hw/s390x/sclp.c          | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 515dcf51b5..da2333846f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -394,57 +394,58 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
 
     dev_st = get_boot_device(0);
     if (dev_st) {
         ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     }
 
     /*
      * Currently allow IPL only from CCW devices.
      */
     if (ccw_dev) {
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
             ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
             ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
             ipl->iplb.scsi.target = cpu_to_be16(sd->id);
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
             ipl->netboot = true;
             /* Fall through to CCW_DEVTYPE_VIRTIO case */
+            fallthrough;
         case CCW_DEVTYPE_VIRTIO:
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         }
 
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
             ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
 
         return true;
     }
 
     return false;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 30149546c0..171320384c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1330,83 +1330,83 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint8_t dmaas;
     uint32_t fh;
     ZpciFib fib;
     S390PCIBusDevice *pbdev;
     uint32_t data;
     uint64_t cc = ZPCI_PCI_LS_OK;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
     fh = env->regs[r1] >> 32;
     dmaas = (env->regs[r1] >> 16) & 0xff;
 
     if (dmaas) {
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_STPCIFC_ST_INVAL_DMAAS);
         return 0;
     }
 
     if (fiba & 0x7) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
     pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), fh & FH_MASK_INDEX);
     if (!pbdev) {
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
 
     memset(&fib, 0, sizeof(fib));
 
     switch (pbdev->state) {
     case ZPCI_FS_RESERVED:
     case ZPCI_FS_STANDBY:
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     case ZPCI_FS_DISABLED:
         if (fh & FH_MASK_ENABLE) {
             setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
             return 0;
         }
         goto out;
     /* BLOCKED bit is set to one coincident with the setting of ERROR bit.
      * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
     case ZPCI_FS_ERROR:
         fib.fc |= 0x20;
-        /* fallthrough */
+        fallthrough;
     case ZPCI_FS_BLOCKED:
         fib.fc |= 0x40;
-        /* fallthrough */
+        fallthrough;
     case ZPCI_FS_ENABLED:
         fib.fc |= 0x80;
         if (pbdev->iommu->enabled) {
             fib.fc |= 0x10;
         }
         if (!(fh & FH_MASK_ENABLE)) {
             env->regs[r1] |= 1ULL << 63;
         }
         break;
     case ZPCI_FS_PERMANENT_ERROR:
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_STPCIFC_ST_PERM_ERROR);
         return 0;
     }
 
     stq_p(&fib.pba, pbdev->iommu->pba);
     stq_p(&fib.pal, pbdev->iommu->pal);
     stq_p(&fib.iota, pbdev->iommu->g_iota);
     stq_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
     stq_p(&fib.fmb_addr, pbdev->fmb_addr);
 
     data = ((uint32_t)pbdev->isc << 28) | ((uint32_t)pbdev->noi << 16) |
            ((uint32_t)pbdev->routes.adapter.ind_offset << 8) |
            ((uint32_t)pbdev->sum << 7) | pbdev->routes.adapter.summary_offset;
     stl_p(&fib.data, data);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index eff74479f4..9b8c7ff043 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -50,28 +50,28 @@ static inline bool sclp_command_code_valid(uint32_t code)
 static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t sccb_len,
                                  uint32_t code)
 {
     uint64_t sccb_max_addr = sccb_addr + sccb_len - 1;
     uint64_t sccb_boundary = (sccb_addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
     switch (code & SCLP_CMD_CODE_MASK) {
     case SCLP_CMDW_READ_SCP_INFO:
     case SCLP_CMDW_READ_SCP_INFO_FORCED:
     case SCLP_CMDW_READ_CPU_INFO:
         /*
          * An extended-length SCCB is only allowed for Read SCP/CPU Info and
          * is allowed to exceed the 4k boundary. The respective commands will
          * set the length field to the required length if an insufficient
          * SCCB length is provided.
          */
         if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
             return true;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         if (sccb_max_addr < sccb_boundary) {
             return true;
         }
     }
 
     return false;
 }
@@ -207,28 +207,28 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
 static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
                                       bool configure)
 {
     int rc;
 
     if (be16_to_cpu(sccb->h.length) < 16) {
         rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
         goto out_err;
     }
 
     switch (((IoaCfgSccb *)sccb)->atype) {
     case SCLP_RECONFIG_PCI_ATYPE:
         if (s390_has_feat(S390_FEAT_ZPCI)) {
             if (configure) {
                 s390_pci_sclp_configure(sccb);
             } else {
                 s390_pci_sclp_deconfigure(sccb);
             }
             return;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         rc = SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED;
     }
 
  out_err:
     sccb->h.response_code = cpu_to_be16(rc);
 }
-- 
2.39.2


