Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFCC718E03
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Tus-0000MC-9a; Wed, 31 May 2023 18:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4Tuo-0000Ef-5r
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:03:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4Tum-0004xa-Fz
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:03:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96f6a9131fdso4831766b.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685570610; x=1688162610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y61AYZ/YcY5Em/65cYpf5XkCjZPYAIOwqhb1xwUDk5c=;
 b=p8vLl4FNCKlikqPVNa/la57B1TZOZJEh5e+QfeM0mreq970MtZfcavu+l5iDs/V1/l
 9xzKPia10KaYZTOXeZNgG+gHlGh99JnXba1JfxYLdN3v7mu0rYr+4ZGa7QU1+P31Li8u
 v/mL8hdmbYCmU+YnjDQxMoV/hF9cSbP4m8cqDzVFcV9AopaWTBjdIhWwyfUDNFzkk7jp
 TmZaGDtcWUMaXIYUCExbYeuvHs8t0WGVPaflwIMm58RRcVhzCF/GHaMRwA7limDAmWpB
 KCzWy6Wl/dq+HOC6SxkeuDRvhKCrgei2BhzxlhaO6SKU++M7bVIxEINdtaYU7gCI3ZpZ
 yztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685570610; x=1688162610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y61AYZ/YcY5Em/65cYpf5XkCjZPYAIOwqhb1xwUDk5c=;
 b=cJ1rDaoBbwfmLOq9Am4gNGajthjBrCrjOV8xJMxwHa6aHXQVJ+nO5W1w8vNQ9MjTyQ
 RHMKeABzRZ/bmAqHi1Thq60Fv2ldXkFrf0EfYRgP1Tsbz4cUOK/MmM5X5bKZieI6NXgh
 N+YfX3Q+wOOCD9n8PZN7UPHFbver0A5xyRV6crtwofbQ8pps1AVaZudk/gacbW3waAOZ
 aG9c8FT66lF4LNKhHihK8fZJngINPp2/XPmfeKK+nG5wKTQF7JXT0KjJxqLRFSKIsV0f
 pR6eHIAVjNjFMm302BDE0Hizlkdxt1Oo+h6SttunkBNnYCJj5gLJu3gFFoulro/40Cdq
 l6+A==
X-Gm-Message-State: AC+VfDxMJJPvp7Pjk9pZWiagb1M8EyaBo2t7cDzP2X7ZtXY3O5alHQZK
 LDc0i0tUQGPknrwelp2PnNuPqQ==
X-Google-Smtp-Source: ACHHUZ45+Pq/2BY84a+NfuDiqM2l16x8a1aN7ZsIcuOTHbBtxzyrpcZNuwrz6oEaSpNbXZGcG5P0Sw==
X-Received: by 2002:a17:907:6d93:b0:959:5407:3e65 with SMTP id
 sb19-20020a1709076d9300b0095954073e65mr7132080ejc.55.1685570610563; 
 Wed, 31 May 2023 15:03:30 -0700 (PDT)
Received: from [192.168.178.121] (dhcp-077-251-030-138.chello.nl.
 [77.251.30.138]) by smtp.gmail.com with ESMTPSA id
 q9-20020a170906940900b009545230e682sm9663945ejx.91.2023.05.31.15.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:03:30 -0700 (PDT)
Message-ID: <8fcc0a5d-ee66-246b-8d0e-2503fbb32633@streamhpc.com>
Date: Thu, 1 Jun 2023 00:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 4/4] vfio/pci: Enable AtomicOps completers on root
 ports
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-5-alex.williamson@redhat.com>
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230526231558.1660396-5-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=robin@streamhpc.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
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



On 5/27/23 01:15, Alex Williamson wrote:
> Dynamically enable Atomic Ops completer support around realize/exit of
> vfio-pci devices reporting host support for these accesses and adhering
> to a minimal configuration standard.  While the Atomic Ops completer
> bits in the root port device capabilities2 register are read-only, the
> PCIe spec does allow RO bits to change to reflect hardware state.  We
> take advantage of that here around the realize and exit functions of
> the vfio-pci device.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Robin Voetter <robin@streamhpc.com>
Tested-by: Robin Voetter <robin@streamhpc.com>

Kind regards,

Robin Voetter

