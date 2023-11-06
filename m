Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A437E1CAC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:54:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzvMK-0000hz-Fn; Mon, 06 Nov 2023 03:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzvMG-0000hg-IH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:53:20 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzvME-00067j-V0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:53:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so28514955ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 00:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1699260797; x=1699865597; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X5rqoz5D1jH+1WTYdmget98uHt0pXGv7lHVb2Qejfl8=;
 b=bVWhH0bwCj5f9WA9S9XMn24cUzsWTlzRh2d6eLD/iyapITBDwdGxiIdWsavbsl3Tlq
 MZ/+Yq/S/bz6iU41mECjUAIBaJNb04P+tGnbZn1BSkJoOmHL5vAWmxGhtiXwGXI7sr82
 +0Mes8FK8pPVn7WMz4ZA0ma63RnWM+GswK+IWyrmMNSh9sCJuoWV025DyCW8IxNhhXNq
 nLG8PVyaqGQRaHBj9+l7DGGh8aId4tWLVygfcNzcwPlYU2kZUlwqYLnPbaTMeqyptBwL
 ongtZE4BcuoO8WWsD2qHVIc680vIrdyrOJ45eqy72w6xDXa+w9GDcm8dcCiBavHo3oER
 oc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699260797; x=1699865597;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5rqoz5D1jH+1WTYdmget98uHt0pXGv7lHVb2Qejfl8=;
 b=P3zfxmF7Cj4kXnDQLg+0PdMYu4HP58E4nGROiyuKLvVhQYF3+BGmHAJneQ1rD3ljJY
 7L5xhf2vS8EGkq1m5nou8uuSmAY78mTY0uUKzt2Yha6/xEHdMmT2Wshl5AohU3F4LIRp
 AaeBMLR2XWvF3QWFr1f5ElStqk/jmLc2yDt4xiujjjwdkvZoVwr4HKs7GHLohZt46xNz
 9vHB0wLJjcjOMB0wVKrtSfQbmAqoCSDyEfZIVrV9/uwsIMHralxsmsFYaHTNRVOhTxCy
 pd+6Vrq/poXeDV68Ju4DJdw4OA9I63jv+OgnIRi2XBlBQOP1pPCAWeSzeON1pmbG1u4C
 jnIQ==
X-Gm-Message-State: AOJu0YzXK5P0o3TxMuJmPRscHr7nGE0OeZm6j9MtnhZyVIeqF+TbIJ94
 MLg21QFNYCk1b9EvK37/PZbzWQ==
X-Google-Smtp-Source: AGHT+IF4gKkQRGn/4flRT8b5g5G98aM9tZTLJaPaE0/OC7wVyQDABpRYPKS/kMLCY6qQqBJr4u8reA==
X-Received: by 2002:a17:902:d4c2:b0:1cc:5aef:f2cf with SMTP id
 o2-20020a170902d4c200b001cc5aeff2cfmr20477763plg.9.1699260797353; 
 Mon, 06 Nov 2023 00:53:17 -0800 (PST)
Received: from localhost ([123.231.98.201]) by smtp.gmail.com with ESMTPSA id
 iw21-20020a170903045500b001c8a0879805sm5418903plb.206.2023.11.06.00.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:53:16 -0800 (PST)
Date: Mon, 6 Nov 2023 14:23:13 +0530
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, pbonzini@redhat.com,
 lists@philjordan.eu
Subject: Re: [PATCH v2 4/4] i386/hvf: Fixes dirty memory tracking by page
 granularity RX->RWX change
Message-ID: <ZUipeV8DIwUv32-B@roolebo.dev>
References: <20231021200518.30125-1-phil@philjordan.eu>
 <20231021200518.30125-5-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231021200518.30125-5-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Sat, Oct 21, 2023 at 10:05:18PM +0200, Phil Dennis-Jordan wrote:
> When using x86 macOS Hypervisor.framework as accelerator, detection of
> dirty memory regions is implemented by marking logged memory region
> slots as read-only in the EPT, then setting the dirty flag when a
> guest write causes a fault. The area marked dirty should then be marked
> writable in order for subsequent writes to succeed without a VM exit.
> 
> However, dirty bits are tracked on a per-page basis, whereas the fault
> handler was marking the whole logged memory region as writable. This
> change fixes the fault handler so only the protection of the single
> faulting page is marked as dirty.
> 
> (Note: the dirty page tracking appeared to work despite this error
> because HVF’s hv_vcpu_run() function generated unnecessary EPT fault
> exits, which ended up causing the dirty marking handler to run even
> when the memory region had been marked RW. When using
> hv_vcpu_run_until(), a change planned for a subsequent commit, these
> spurious exits no longer occur, so dirty memory tracking malfunctions.)
> 
> Additionally, the dirty page is set to permit code execution, the same
> as all other guest memory; changing memory protection from RX to RW not
> RWX appears to have been an oversight.
> 

Hi Phil, I don't observe a problem with SVGA if I apply CPU kick patch
on top of it. Thanks for fixing this,

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Regards,
Roman

