Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD087F5C44
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:26:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66uS-0004Dp-F9; Thu, 23 Nov 2023 05:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r66uQ-0004Df-Ll
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:26:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r66uP-0004UP-2x
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:26:10 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so401289f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700735167; x=1701339967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5WL9GepGmUkgUSx+/uvt9VAobqmTdVCou+4PBkeG/g8=;
 b=lcNpqa+HQW80TSdRV2a9GWlBgBZ84t1YGyDH243Npy87K2sRwSIuvwGd9ckfaFujwV
 J5X+Vocj72SxjVlkxgUgRonhCfb4ptvL7mc0nMmaamL3/frdPi2DUmH9Oe3RjuTNLO7i
 GSNBA9HShb7wXVV3tncHmdjnICMxd7/KwG3w6unQsaea6FyRVC5Bo18L7CgPf68swFtU
 qRjwEEJ0RJXqiKfhPCCbGTkxzZ7YKGEfn1hwGLYSfWMski/A3LMHPHdelWMJalW+yuul
 8iQvVxje9BB8cBvUHYr8SLFGzK3FXpGM68IOBZwExoOTwWbxu4M6zMMu0xgOfHkElWL9
 D9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735167; x=1701339967;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5WL9GepGmUkgUSx+/uvt9VAobqmTdVCou+4PBkeG/g8=;
 b=EYJ5hr3UQxvPs/0TGMPzT0YZyqSYyYCSnoE5FXaoXnQzfuzat9gmZgxc4ArmpRKbMl
 4MGHXTVc5OxTV+DcOgW8iZGoZX0GIvqiXT1G4tSsPdpSZ7j5cah2Z5RH8Fl4AG5lPlX2
 lzy2GOwZsaeI2nNonzcaGuc47No0QCvtE5sap0klZnKldbAZveng1WBqQc1KXLM5teoH
 BpOeu3EhHAgB6PwJYGrgSMbxGiBqPxdrEztpVveTQ9Fb7oWiWQrHtcsH14NXaQZtye6u
 uiUxAVQ4TBSRFdwmbJqdjVL9uiIpFW+vAnpr6F2HEGSjgeQ74glB2/otq4YNCKQZRGYE
 LfLQ==
X-Gm-Message-State: AOJu0YyPqB+AvdIG40JDGBmEVIENvNOrumP2wHOvgrRzc96beUPV96EJ
 IRdwgnDqYRGKbXQg2J8tgq4ZWQ==
X-Google-Smtp-Source: AGHT+IFGmnx/YuV4gnltlZ5Xjnv0SL2+DgxnKV1MIyeV9WzctmPVdXpga45kJ8zvU3whi4OhccJyuA==
X-Received: by 2002:adf:e881:0:b0:32f:dd2f:9b93 with SMTP id
 d1-20020adfe881000000b0032fdd2f9b93mr1624144wrm.9.1700735167163; 
 Thu, 23 Nov 2023 02:26:07 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adffc50000000b003313902cef5sm1225569wrs.93.2023.11.23.02.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:26:06 -0800 (PST)
Date: Thu, 23 Nov 2023 12:20:25 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH for-8.2] ui/pixman-minimal.h: fix empty allocation
User-Agent: meli 0.8.4
References: <20231121093840.2121195-1-manos.pitsidianakis@linaro.org>
 <e1647b07-939e-40f3-a8fb-66596dcb862c@tls.msk.ru>
In-Reply-To: <e1647b07-939e-40f3-a8fb-66596dcb862c@tls.msk.ru>
Message-ID: <4knng.4jj03b8scuu9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Thu, 23 Nov 2023 12:15, Michael Tokarev <mjt@tls.msk.ru> wrote:
>21.11.2023 12:38, Manos Pitsidianakis :
>> In the minimal pixman API stub that is used when the real pixman
>> dependency is missing a NULL dereference happens when
>> virtio-gpu-rutabaga allocates a pixman image with bits = NULL and
>> rowstride_bytes = zero. A buffer of rowstride_bytes * height is
>> allocated which is NULL. However, in that scenario pixman calculates a
>> new stride value based on given width, height and format size.
>
>So, does rutabaga depend on pixman (as mentioned on irc), or can the
>minimal in-qemu version (with this fix) be used?

I think it probably does not depend on missing functionality; it seems 
to only be passing the allocated data to the external library and not 
pixman types. I'd have to check on amd64 where I previously ran rutabaga 
successfuly in qemu; now I'm trying to get it to work on aarch64 and I'm 
trying to figure out some control message errors from the guest kernel 
driver. When/if I try it again on amd64 and it's not working, I will 
either report or send a patch.

