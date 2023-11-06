Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2897E199F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 06:25:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzs67-0000lv-An; Mon, 06 Nov 2023 00:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzs65-0000li-Bg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:24:25 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzs63-0002s7-Rq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:24:25 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28028f92709so3150195a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 21:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1699248262; x=1699853062; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p4mSP0f7l2kf44JX/Yavv7rfdZHZWWAdwAluJWybLHI=;
 b=eNq43bwyhXFI84MykqBMp01gQhA/B07gsdMS+eXBI4RAp5w0ARvRiBgnFrc+4Qa5oH
 yevKWlGEyxrSlMNOsrZqfeA9JpwFMRrW/bopFGOShGBVrgvjZBW3UnviH+eRrbYptIFc
 lRJon1YgrgyisH88ZpT/kun/eZBCE2tr4sAOQYFfqRUIklwjrKaVN8P2ohqXHaCCB42z
 87rAioiYDeZiFk3R0KjgAsshhpcm3F1LOMpNEWq37qIVuBTfxWk/Zg/8hFrG3OjdhulK
 QvzNhTss0cCTwof5NcpMG0lD/Zr4a7uUw2CJ+j5tOvMNEfDqyL6s+cy+Z8N2mgbKipyb
 qgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699248262; x=1699853062;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4mSP0f7l2kf44JX/Yavv7rfdZHZWWAdwAluJWybLHI=;
 b=B+M3g7AXxfPqvAq9U65ExF9dX+8am38Pnk2CQLhVBUfAfE74U54iLyCk6jf6wa7acW
 cj0thu7nCApL0DHdPJe4iyk/XPwSB8QFKFEJIyZf9AtTKyq50a6vJ7/DwIxcfwClf9pz
 BBjaaud0l0dci7d7EEpvAYCs5gVlsqdGCroj80Ag/CUeU9OnZsX1qctAM55XLq+SklWp
 NCLXsCEpkHXfppW4/2H8nI4qq86IUXciLOWoCsbsrmweXoGsCGJxSKz3fKND4AmRkrdW
 Dz91N8iNfH9gLsi0ZAENfiFZqwV6FDtafoK1uVCYA2HwIsY7Na7kIRi9rj8pi9FcrDPv
 kP/A==
X-Gm-Message-State: AOJu0Yw5iIf7VD8aF4XuVf6l86TJjPN7eeDD9MdyPvuLDy46YZpeCGxp
 /xMt03hSdI/N8PEkP7+cbeEkVAIO7kne0UtouVaPsA==
X-Google-Smtp-Source: AGHT+IH7kRy0smuK8xHoyZrO7AupQ2IMDLtJTUkgar98JdAmbdHqfwX762mMxDlL7bsfIU2jXPMJPg==
X-Received: by 2002:a17:90b:1b04:b0:268:808:8e82 with SMTP id
 nu4-20020a17090b1b0400b0026808088e82mr12518865pjb.1.1699248262389; 
 Sun, 05 Nov 2023 21:24:22 -0800 (PST)
Received: from localhost ([123.231.99.131]) by smtp.gmail.com with ESMTPSA id
 jd2-20020a170903260200b001c9ccbb8fdasm4951213plb.260.2023.11.05.21.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 21:24:21 -0800 (PST)
Date: Mon, 6 Nov 2023 10:54:19 +0530
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, pbonzini@redhat.com,
 lists@philjordan.eu
Subject: Re: [PATCH v2 3/4] hvf: Consistent types for vCPU handles
Message-ID: <ZUh4gyu8-7jxoZD0@roolebo.dev>
References: <20231021200518.30125-1-phil@philjordan.eu>
 <20231021200518.30125-4-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231021200518.30125-4-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=roman@roolebo.dev; helo=mail-pj1-x1030.google.com
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

On Sat, Oct 21, 2023 at 10:05:17PM +0200, Phil Dennis-Jordan wrote:
> macOS Hypervisor.framework uses different types for identifying vCPUs,
> hv_vcpu_t or hv_vcpuid_t, depending on host architecture. They are not just
> differently named typedefs for the same primitive type, but reference
> different-width integers.
> 
> Instead of using an integer type and casting where necessary, this change
> introduces a typedef which resolves to the active architecture’s hvf typedef.
> It also removes a now-unnecessary cast.
> 

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Regards,
Roman

