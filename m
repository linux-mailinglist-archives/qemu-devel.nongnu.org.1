Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065917E2927
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:54:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01vT-0007tv-IH; Mon, 06 Nov 2023 10:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r01vR-0007r4-75
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:54:05 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r01vP-0008Vw-Jn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:54:04 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so62703741fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699286041; x=1699890841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nt6CguaXRq/YZ+PZ3lvfxXKUnqOduWpE0HGPF4W1wY0=;
 b=Olad5gXQo9jU+6cGexr6wlIPU1KBxFrgMSt0V7KN7LQBCpcr1f6VsoHQyymancuTXr
 JphtVgofWCKxtd8LcB6IeWGo9gaTGOtwVi9Sy7Z/aPUuPmAyZCImaGgP64SYiFzZhg5A
 7KrnKv0WWuUMCEQRp5WoSb5n0E9usYmJwf3yPnCrJnn3fdqPZL53rfx3IMyFLHvzNcOp
 xmzqoOlPdNVZATixLIDqvZV8diBwCYl15On0PFSny7HEqZI0aU4ZYfl/QLLl96CGeIJ5
 2Is0Vx+eu1vtaUuLTA62n7ryV97CBvbmTievODRZ81ptSIqMu4beIS73ObIYmVI2NUZ8
 XIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699286041; x=1699890841;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nt6CguaXRq/YZ+PZ3lvfxXKUnqOduWpE0HGPF4W1wY0=;
 b=imFf3sWoyQpECJ7AAF4uBQedmn8+gbZ+WMgKDhVw1awgTmcSPv2Z5F9IJVkd+tk6PZ
 cQ9JC+4D4wI82xqOTACrwZ2MskkJgZvF9Y4fPfq9altAEWWD+cjlnXC4/sboifRTrYfw
 EgsKv2tvrACA+D9HjS0umOau9AoEMZLw8rwjOQTMW1K1NTuMJ42uYTsf1XSggc9Zl6je
 sek1hZpOBfuVQYJfmUqbxtaf8yKATJ5bC3xc3iGjaxO/7+xQDVdqZtUM5baIrAEj1dgb
 rpxE3sCChYkE/UxuioaDW8ATZuLJF5H4zz6zrNMopCRKiwq+gtTKV6qNdAsiZ6zfKe4e
 4mrA==
X-Gm-Message-State: AOJu0YyPbeTGc/ABI5MrmeDUtauO1xZuQLvUAhzKKBm5qqYGfTZuRGJz
 g5tHyyXuQLDa/OLpIELwHf0=
X-Google-Smtp-Source: AGHT+IGCoYjqZL7KCS5nKOgoZCWqBe7yFIheTDPrXy3X0fCB+qVxX20b8MuMAQC0/PdVpz/QlzJQHg==
X-Received: by 2002:a2e:8692:0:b0:2c5:2191:3f35 with SMTP id
 l18-20020a2e8692000000b002c521913f35mr24457967lji.2.1699286040925; 
 Mon, 06 Nov 2023 07:54:00 -0800 (PST)
Received: from [10.95.110.31] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b004064ac107cfsm12608013wmq.39.2023.11.06.07.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:54:00 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d8838073-5169-4f84-bc98-912f5afa285b@xen.org>
Date: Mon, 6 Nov 2023 15:53:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/pt: Emulate multifunction bit in header type
To: Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20231103172601.1319375-1-ross.lagerwall@citrix.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20231103172601.1319375-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x22f.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 03/11/2023 17:26, Ross Lagerwall wrote:
> The intention of the code appears to have been to unconditionally set
> the multifunction bit but since the emulation mask is 0x00 it has no
> effect. Instead, emulate the bit and set it based on the multifunction
> property of the PCIDevice (which can be set using QAPI).
> 
> This allows making passthrough devices appear as functions in a Xen
> guest.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Reviewed-by: Paul Durrant <paul@xen.org>


