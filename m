Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF507F4DD2
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 18:08:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qhO-0006NK-MB; Wed, 22 Nov 2023 12:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qhM-0006K9-NH
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 12:07:36 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qhG-0004YN-UL
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 12:07:36 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33139ecdca7so4310376f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700672849; x=1701277649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6fGZPxbwGMY3QWkow4475z+MXvadUM3v7KWn5MxJLcs=;
 b=I1dISajg6zyN6PVBuE3sYSA18tzDnA4+vr1gf2e35MbNScrbgXT0HNWkli+v2hsp6G
 MnCYKy7+UVgU8MtY8wsGoL7lIakA7gHyD+Mmx/9TI/dPXtIAHv5mrhCY2gVU9DERmwQP
 X9VxAZL1fRTExRXecVuYMZe+ni1DqKMtTUWIT73TcAS8cK5giO3ndHnKsGQk0GNY9MsI
 sG1bnZvC/nCp2nlnAGNcR2300vz5A1VmAKq3OP65p2ESHwU288KFN557+av2k6anjZUw
 o4HLH+u3mrOmgFnXHHIx5iEboNl6fXxn7XFAuV8Koj+bEk/vUZfIK+OrAF2HNnYuPk5q
 6iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700672849; x=1701277649;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fGZPxbwGMY3QWkow4475z+MXvadUM3v7KWn5MxJLcs=;
 b=cNuzfutx1HU/wnwtiNbGYVLM8En40sIv0GXb7lZS/MP2bJEHftfEeRpm8vMpKVoTWG
 U9W5cR64Wk2tf/WX8Da9mSduCg2clftwXZyLXXVYPJL8f2qLNFP19l70GNU+j/1ptEeE
 vNg7P+L5ZmbCLGWWLdrJ2wlNLhUpIiT59u4R5yQmsMuNSbddrxg5OiDy/JLoGqIJnSso
 uR8P3Do2oGZWzFq25EdM3YOQL6hz21h+8OKvkBhehoQWZyImKb0SBVSqX+Gcbel9k6d4
 JTb2e/SDJ7eWGLZ4Ds5gQlfp0390vi0ctTZ29Q57RJ4pfJzXz+VvmbbwbWGygcbv4qIP
 2YiA==
X-Gm-Message-State: AOJu0YzaLhAEED+p/BuWI0fdS0vYau1cmNGI77Ch9lww9RtiH0PLPIus
 np8KF5sAa1bPBgLjZojoTaE=
X-Google-Smtp-Source: AGHT+IFsCnypPtHuEh0bNMMwNDbRPFPmk2JKHo2KVYW81JB+V3OGjDLa5vUOmIkzPbDLF5Q1hxT3Yw==
X-Received: by 2002:a05:6000:b87:b0:331:6a36:a05f with SMTP id
 dl7-20020a0560000b8700b003316a36a05fmr1950659wrb.65.1700672849171; 
 Wed, 22 Nov 2023 09:07:29 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0032f7e832cabsm17673508wrx.90.2023.11.22.09.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 09:07:28 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c9b15b1c-e86b-45b4-b348-8c9edde5e60d@xen.org>
Date: Wed, 22 Nov 2023 17:07:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] xen: xenstore: add possibility to preserve owner
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 David Woodhouse <dwmw2@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-4-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231121221023.419901-4-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> Add option to preserve owner when creating an entry in Xen Store. This
> may be needed in cases when Qemu is working as device model in a

*may* be needed?

I don't undertstand why this patch is necessary and the commit comment 
isn't really helping me.

> domain that is Domain-0, e.g. in driver domain.
> 
> "owner" parameter for qemu_xen_xs_create() function can have special
> value XS_PRESERVE_OWNER, which will make specific implementation to
> get original owner of an entry and pass it back to
> set_permissions() call.
> 
> Please note, that XenStore inherits permissions, so even if entry is
> newly created by, it already has the owner set to match owner of entry
> at previous level.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>


