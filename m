Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147882CCB0
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 13:29:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOd7h-0000z7-Oa; Sat, 13 Jan 2024 07:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7M-0000yg-Ck
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7K-0007ne-Eb
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso550905e9.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705148880; x=1705753680; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjpf4U6Ficv9bUwVJnIdKdbrQ8+edT4V7CyfmwDK7x4=;
 b=Yay4k8ni9keuse0HTt7fbUonhZ/LnD59hz7mVh1D8MXZ0PSyr5iRtM+lvsgX9B6F8Y
 fgZwunVhHAM1ue+FwuyY6PwhCvlAOIuUag9aLuyHgUPAECmlveXtBQ1+2/WQhNDLAPuV
 PhsK4KQOf0Sz2KwSME7zxCsFHmmjJme/jN+sNnU0KsPpkmReybFvrKOipxbUzLW/5lbI
 Geaw8DakC4JlyfvvCZY+SuJxVDEASChzxXSr1V104kHX3r5tZFMG6774EQcCqGnhiRjn
 itiR6NinGW09CC7QxemOICqFAzxF4sn/CRdlqJj7Vx4BR46QNdj4DLpvBgJbr6NNhOeP
 sOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705148880; x=1705753680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjpf4U6Ficv9bUwVJnIdKdbrQ8+edT4V7CyfmwDK7x4=;
 b=XCUzTcp+nq3f6YlegJm6BYkmGsj/4cj0WXuAjuWU3ieDh3xNVOyNr4qizPzLRlzWmN
 Ona3kxSXNmYq7bNdYlbmtlkpMY2asqdCSPw/OGwteapvoqYA52Wd9z3igAqzW82lCYMe
 dS72FinWgxxd/7tezD0ksGjcVuRmJl9gLkfjFcn+boSeXwYGlW9hVrLgL6wqJ8DkFikE
 csYvIVd3ZG68gussxFuP1ZbiW/ZaVvyLzEEofh8rk23w725iPyIGsV5VcG3GOWQIIYmb
 aQDV4tsBTgCWWs5eI5z07+y8S5Fro7sA1vK6q7wNSBzcuaHLS1dzub8TN1hVmdNf3NCj
 WUtA==
X-Gm-Message-State: AOJu0Ywok5dihUDQwq4zNWzpEPXdPVoi5qfGQK7quYXiSRuSMymHGdaQ
 erVCAUboSyge/SHKN/+wsqE4yV+kmdClNQjVnTZjKTUsPJ4jJA==
X-Google-Smtp-Source: AGHT+IENpFIgtQmRhHDrOLZOBnUNbJGrjzYAfqMafRkPIW6yVCOr9PjaZfz5iJNAADYb5/AXfIsUR1GAK7GJC51pkgc=
X-Received: by 2002:a05:600c:5387:b0:40e:5186:7ed1 with SMTP id
 hg7-20020a05600c538700b0040e51867ed1mr1067787wmb.25.1705148880639; Sat, 13
 Jan 2024 04:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
 <20240110234232.4116804-9-nabihestefan@google.com>
In-Reply-To: <20240110234232.4116804-9-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 12:27:27 +0000
Message-ID: <CAFEAcA-iP01=MCOMntqHm-VdZGwO+w7Ba36s7qvZJsHTWWkCKA@mail.gmail.com>
Subject: Re: [PATCH v12 08/10] hw/net: GMAC Rx Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - Implementation of Receive function for packets
> - Implementation for reading and writing from and to descriptors in
>   memory for Rx
>
> When RX starts, we need to flush the queued packets so that they
> can be received by the GMAC device. Without this it won't work
> with TAP NIC device.
>
> When RX descriptor list is full, it returns a DMA_STATUS for software
> to handle it. But there's no way to indicate the software has
> handled all RX descriptors and the whole pipeline stalls.
>
> We do something similar to NPCM7XX EMC to handle this case.
>
> 1. Return packet size when RX descriptor is full, effectively
> dropping these packets in such a case.
> 2. When software clears RX descriptor full bit, continue receiving
> further packets by flushing QEMU packet queue.
>
> Added relevant trace-events
>


> +static int gmac_read_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
> +{
> +    if (dma_memory_read(&address_space_memory, addr, desc,
> +                        sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read descriptor @ 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
> +    desc->tdes0 = le32_to_cpu(desc->tdes0);
> +    desc->tdes1 = le32_to_cpu(desc->tdes1);
> +    desc->tdes2 = le32_to_cpu(desc->tdes2);
> +    desc->tdes3 = le32_to_cpu(desc->tdes3);
> +    return 0;
> +}
> +
> +static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
> +{
> +    struct NPCMGMACTxDesc le_desc;
> +    le_desc.tdes0 = cpu_to_le32(desc->tdes0);
> +    le_desc.tdes1 = cpu_to_le32(desc->tdes1);
> +    le_desc.tdes2 = cpu_to_le32(desc->tdes2);
> +    le_desc.tdes3 = cpu_to_le32(desc->tdes3);
> +    if (dma_memory_write(&address_space_memory, addr, &le_desc,
> +                        sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to write descriptor @ 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
> +    return 0;
> +}

The series doesn't compile at this point, because:
../../hw/net/npcm_gmac.c:238:12: error: unused function
'gmac_read_tx_desc' [-Werror,-Wunused-function]
static int gmac_read_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
           ^
../../hw/net/npcm_gmac.c:253:12: error: unused function
'gmac_write_tx_desc' [-Werror,-Wunused-function]
static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
           ^

(this might be a clang-only warning).

The fix is to move these two function definitions into
the following patch, where we add the code that uses them.

-- PMM

