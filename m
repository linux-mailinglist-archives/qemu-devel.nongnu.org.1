Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C575B869
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZni-0000BM-9F; Thu, 20 Jul 2023 15:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZnf-0000Ay-Qh
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:58:59 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZne-0004Wt-83
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:58:59 -0400
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-403c653d934so10131911cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689883136; x=1690487936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fa8bJb04ZvnnRNi76wtYTjDMEYPR/K0aZDQRNb+Huq4=;
 b=YCf8bPc1cYh8csFGHCDH5OgYzlhnTh+TGOKxMOeVLCJxWAP9h/MRTI0ESXIXjN0yIv
 cHVx5O7Cod0KWsjpXauEuYW1F1l3XbA5xVMbGyik34vh227IcEUTRZIQO2nx6BAB2Ihu
 +1rvcwA16fJb1KIzJS0MCitSdtZ8/5NQLTWvv6DoiQ9cxzkXgGMgbsMvCFLJNldilCbv
 jKWoRpx4SOfOxOxDL9C9aESAPpRabVDogid7MJRyl2GFo3yOdr9ofIJ4B7nOV0oam4Ci
 ofL270lFrBkAx27TIQNwK63jxaEFRk6rY29gjQ+HPWQbhkVEi2g6tbu4gxWGNcBPRKvV
 GpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689883136; x=1690487936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fa8bJb04ZvnnRNi76wtYTjDMEYPR/K0aZDQRNb+Huq4=;
 b=MK4HDtnge16Ubym5EBlOnCFclLi9j2lwQWtjNFJ97DkEhkLHeK7Fkb5Ph6dERp7GAu
 PCk/FfTQESNxFLnfdM/jg3bdF3EzZe1PBV5aXdEuOT5dxaLCkIQnMLYvRNmO241ibvYB
 TIv+SiKDOfDpTHRB2N6iUj1a+JRyJzjuDD2V9B3abc1VEvHH8kYLA0TP+mndvb06+KWF
 iKvO0h6GXCGlb4Do/t5cCRZdwzEfMftp4xVYM5kgptVLe1sd+nNobrmK5DBhkrnBW36y
 YMnRcHO2mQQigcJ9KjmArBsFhB8LdS8jLdbJgL8XQwPM7nHfYAPWsv7eNxYz3Q0COS29
 tLww==
X-Gm-Message-State: ABy/qLZEGflT/qnOzX3uaT3oEZYl2s+c7ms59TY5zEhs1dTn6fS0FxSA
 uoxsFToq5FfMRjfLhhoX8tPz4VbutuhE
X-Google-Smtp-Source: APBJJlETfN33UWv770rWJnBpgm1Ey0TWkso52q9W88hXKhV4uCHLE0X7bAen/XT3I4DSAIpG8/x/+g==
X-Received: by 2002:a05:622a:647:b0:403:b86d:f10e with SMTP id
 a7-20020a05622a064700b00403b86df10emr129479qtb.10.1689883136587; 
 Thu, 20 Jul 2023 12:58:56 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.12.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 12:58:56 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
Subject: [RFC 0/2] Modify CCI cmd sets to be mutable
Date: Thu, 20 Jul 2023 15:58:18 -0400
Message-Id: <20230720195819.17905-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=gourry.memverge@gmail.com; helo=mail-qt1-x842.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is on top of the proposed CCI changes by Jonathan.

Base repo: https://gitlab.com/jic23/qemu
Base branch: cxl-2023-07-17


A proposal to make the CCI cmd sets full members of their device,
and copy the const struct entries instead of referencing them.
This would allow child devices to inherit the parent device default
behavior, but with the flexibility to override without changing the
core device.

This also enables the base device to receive the commands via the
same /dev/cxl/XXXX device, simplifying testing.


An example of how one might override/add commands (paraphrased):


instantiating:

-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0
-device cxl-my-cmds,target=cxl-mem0


simple code:

static const struct cxl_cmd cxl_cmd_set_my_cmds[256][256] = {
    [MY_CMDS][GET_INFO] = { "SPECIAL_GET_INFO",
      cmd_my_cmds_get_info, 0, 0 },}

static void cxl_my_cmds_realize(DeviceState *d, Error **errp)
{
    CXL_MyCmds_State *s = CXL_MyCmds(d);

    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
        CXLType3Dev *ct3d = CXL_TYPE3(s->target);

        s->type = cxl_type3;
        s->cci = &ct3d->cci;

        cxl_add_cci_commands(&ct3d->cci, cxl_cmd_set_my_cmds, 512);
        return;
    }
    error_setg(errp, "Unhandled target type for CXL MHDSLD");
}

#define TYPE_CXL_Niagara "cxl-my-cmds"
static const TypeInfo cxl_my_cmds_info = {
    .name = TYPE_CXL_MyCmds,
    .parent = TYPE_CXL_TYPE3,
    .class_size = sizeof(struct CXL_MyCmdsClass),
    .class_init = cxl_my_cmds_class_init,
    .instance_size = sizeof(CXL_MyCmds_State),
    .interfaces = (InterfaceInfo[]) {
        { INTERFACE_CXL_DEVICE },
        { INTERFACE_PCIE_DEVICE },
        {}
    },
};

Signed-off-by: Gregory Price <gregory.price@memverge.com>

---
Gregory Price (2):
  cxl/mailbox: change CCI cmd set structure to be a member, not a
    refernce
  cxl/mailbox: interface to add CCI commands to an existing CCI

 hw/cxl/cxl-mailbox-utils.c  | 37 +++++++++++++++++++++++++++++++++----
 include/hw/cxl/cxl_device.h |  4 +++-
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.39.1


