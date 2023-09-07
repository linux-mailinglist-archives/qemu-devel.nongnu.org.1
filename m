Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C416796E63
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 03:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe3U9-0002Yb-4S; Wed, 06 Sep 2023 21:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3U6-0002WH-Gy; Wed, 06 Sep 2023 21:07:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3U4-0004pC-3T; Wed, 06 Sep 2023 21:07:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso3638575ad.2; 
 Wed, 06 Sep 2023 18:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694048818; x=1694653618; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVMY/64ZruIf+VYWIVb6fni7SHMG1zxkcw176uMfF/g=;
 b=GWR9z1npHijVMg81e0L9pJDx1bPmEZhyoDqYHVRk+/KkXPtC8NCkO4QiEt15AiNsoW
 YRZnkN9OigjBX0F7IXeRBpZJbfoWfbv+YIVvW0PJGB8tI6EMZoNcz8w5LTsKtKpdqzAE
 8XsQao2mzDr3+0XpX/y1VGiKHX8e/xq/5W+EIP7Igp/ynDyH4lNuwR50Qq031+pYgQtg
 PKqpP/eBFy7/zwsp1eEeRpzwxA1PL1lvcIMwOHPjFPXF7r/UgUWiPOq1SaWM2w9xDvyX
 0IWkCeLB7CKO8paxxvkbsvwL2LuX4MRlydTW6AW3xWXoeQn6SnBliCLdaIEZxE3wVXgv
 ZYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694048818; x=1694653618;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YVMY/64ZruIf+VYWIVb6fni7SHMG1zxkcw176uMfF/g=;
 b=HpIBSOq5mTay7UIhYIO8qp+sgB0Ig6BirzzxEUd9sUwK1bldtzY4+VK5kDkWo1B0V7
 dh/STV0o3Y5GQWpY3lqBRnk9388cEq8z/0f5HA5nA3nrTaVwTFw1l6KEQpZn/Gl83/3D
 HXWERp81TuLOFcUpWn6UrKXqJN0QZ+uCrxndNbawLMblgMKRwTF/vBW7smwXajyFeRF9
 tQwB0mXrouzT+0NzY9HAOPfZnUT5InM7LGzL+xi/GUV3u4zI5yuyO352XNB6Fi1Y/hWV
 81BdxmIBlOsD4RKRQMXrUFideG8JWVxLE4YsSqtYqAxcJOo/9FZ0F0fAdzGgV/8Iyh/L
 Szlg==
X-Gm-Message-State: AOJu0YzH/bFVdkaSKcWFfG81JAxafm4tVbObsiuIpybqE/PGSetVNnfd
 kWwXPY8Bk1499wfDEur/5s0=
X-Google-Smtp-Source: AGHT+IFNq/w+/pO5iIPwY8J5O1uoMiX6h5xUbk4Pj/LcwNeOYVrWV8nBllF09VCnOowpcm2jCBicKg==
X-Received: by 2002:a17:902:d48e:b0:1bd:ccee:8f26 with SMTP id
 c14-20020a170902d48e00b001bdccee8f26mr18668760plg.15.1694048818015; 
 Wed, 06 Sep 2023 18:06:58 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a170903264c00b001bdb8c0b578sm11655917plb.192.2023.09.06.18.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 18:06:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 11:06:52 +1000
Message-Id: <CVCA6OLHLKVI.2IH1W8J3WBXFY@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 02/15] ppc: spapr: Add new/extend structs to
 support Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-3-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-3-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> This patch introduces new data structures to be used with Nested PAPR
> API. Also extends kvmppc_hv_guest_state with additional set of registers
> supported with nested PAPR API.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr_nested.h | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 5cb668dd53..f8db31075b 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -189,6 +189,39 @@
>  /* End of list of Guest State Buffer Element IDs */
>  #define GSB_LAST                GSB_VCPU_SPR_ASDR
> =20
> +typedef struct SpaprMachineStateNestedGuest {
> +    unsigned long vcpus;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
> +    uint64_t parttbl[2];
> +    uint32_t pvr_logical;
> +    uint64_t tb_offset;
> +} SpaprMachineStateNestedGuest;
> +
> +struct SpaprMachineStateNested {
> +
> +    uint8_t api;
> +#define NESTED_API_KVM_HV  1
> +#define NESTED_API_PAPR    2
> +    uint64_t ptcr;
> +    uint32_t lpid_max;
> +    uint32_t pvr_base;
> +    bool capabilities_set;
> +    GHashTable *guests;
> +};
> +
> +struct SpaprMachineStateNestedGuestVcpuRunBuf {
> +    uint64_t addr;
> +    uint64_t size;
> +};
> +
> +typedef struct SpaprMachineStateNestedGuestVcpu {
> +    bool enabled;
> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
> +    CPUPPCState env;
> +    int64_t tb_offset;
> +    int64_t dec_expiry_tb;
> +} SpaprMachineStateNestedGuestVcpu;
> =20
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
> @@ -228,6 +261,21 @@ struct kvmppc_hv_guest_state {
>      uint64_t dawr1;
>      uint64_t dawrx1;
>      /* Version 2 ends here */
> +    uint64_t dec;
> +    uint64_t fscr;
> +    uint64_t fpscr;
> +    uint64_t bescr;
> +    uint64_t ebbhr;
> +    uint64_t ebbrr;
> +    uint64_t tar;
> +    uint64_t dexcr;
> +    uint64_t hdexcr;
> +    uint64_t hashkeyr;
> +    uint64_t hashpkeyr;
> +    uint64_t ctrl;
> +    uint64_t vscr;
> +    uint64_t vrsave;
> +    ppc_vsr_t vsr[64];
>  };

Why? I can't see where it's used... This is API for the original HV
hcalls which is possibly now broken because the code uses sizeof()
when mapping it.

In general I'm not a fan of splitting patches by the type of code they
add. Definitions for external APIs okay. But for things like internal
structures I prefer added where they are introduced.

It's actually harder to review a patch if related / dependent changes
aren't in it, IMO. What should be split is unrelated or independent
changes and logical steps. Same goes for hcalls too actually. Take a
look at the series that introduced nested HV. 120f738a467 adds all the
hcalls, all the structures, etc.=20

So I would also hink about squashing at least get/set capabilities
hcalls together, and guest create/delete, and probably vcpu create/run.

Thanks,
Nick

