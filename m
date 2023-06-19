Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B8734C25
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB95P-0006um-89; Mon, 19 Jun 2023 03:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB95G-0006u8-Np
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:13:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB95D-0006WB-0k
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:13:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso3162807f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687158829; x=1689750829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNdJMnHWEfLdMYyai3/s7VnhMais+skJEXd3A2ljUug=;
 b=Ubmi6Ydk89eKi1LbaHF78tUlFdIrIk17spOhyolIl3K6CR9HOnCtdEkZEhmS/yR3z1
 PBvRHeAzEY2Ws23US8E24qE9setMbsQTSbMOqhTSF/rGZWDDRbUDk93sqcy2/nsDt8Oy
 ribPY7nRl85jW9oKJkR6L4OIq8r899yoOOlqasqwTMFiuiF5Pqf5JS1yVa6FkVyvRb6v
 7FpYh4A2s+3FWrjPsjWasvwO3Okj8gt5nRpK7Hg7hyDYpEZmP6fy4kgjqGJ/bKivOx02
 58NeSZiUtahO74NY6kM0A2nwi504NsUzZXKUNpN6YncWeXqyeGQwzz3qv6TVULR11HrR
 JSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687158829; x=1689750829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNdJMnHWEfLdMYyai3/s7VnhMais+skJEXd3A2ljUug=;
 b=BP5WUHi758LqdSbo8pUTNeDXNMz1i3kH5TFq4jzC4+xAdEA1ZcdgqdxKJ573/pvZNz
 3EFCIz10WM7hPhNPstpb5+/WaKRj5XstpUiRrPhdHSv9euvpaE71BYrAqg5fY3Y6FTkv
 gcufoUxo5MKOWKW0OJL77FfCBOeeeAKHDiDkT10fkvmdICQh6hu1PHOHhdb4VFt3cNBn
 Dtb1XkdNSheerao+IWbJCvnef+fI4Q7iHnzT236w0MntNtn1yqJ6S5gwCIXq6z6LUe1l
 zPI+3JvzSO9n410YcOFLBQWW4GOyRrapTYZNeyW5VsrAHe7oECp7XSJIO/hOQ29IJ/if
 aaTQ==
X-Gm-Message-State: AC+VfDxq9+NBdoR4CzuezXvc9XOm1opOJdse59hQ9/pDj9y/Z3B6zHQD
 4eSYwvGru3m5f0JBMRdD95hJUg==
X-Google-Smtp-Source: ACHHUZ4sBrCwtnQrtUx3D3+cP1oXAjIdLW+wu/Qw65BnfBxVLaqODZKuC2Iy/whEzKpN+aKSrQINRQ==
X-Received: by 2002:adf:f8c3:0:b0:311:1330:6d56 with SMTP id
 f3-20020adff8c3000000b0031113306d56mr9003676wrq.67.1687158828813; 
 Mon, 19 Jun 2023 00:13:48 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 n16-20020adfe350000000b0030e5b1fffc3sm30782964wrj.9.2023.06.19.00.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:13:48 -0700 (PDT)
Message-ID: <95807a89-5852-b4c2-7c9f-713998d9fc89@linaro.org>
Date: Mon, 19 Jun 2023 09:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, Alberto Faria <afaria@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
References: <20230617053621.50359-1-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230617053621.50359-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/17/23 07:36, Bin Meng wrote:
> Current codes using a brute-force traversal of all file descriptors
> do not scale on a system where the maximum number of file descriptors
> is set to a very large value (e.g.: in a Docker container of Manjaro
> distribution it is set to 1073741816). QEMU just looks frozen during
> start-up.
> 
> The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> doesn't need to manually close the fds for child process as the proper
> O_CLOEXEC flag should have been set properly on files with its own
> codes, QEMU uses a huge number of 3rd party libraries and we don't
> trust them to reliably be using O_CLOEXEC on everything they open.
> 
> Modern Linux and BSDs have the close_range() call we can use to do the
> job, and on Linux we have one more way to walk through /proc/self/fd
> to complete the task efficiently, which is what qemu_close_range()
> does, a new API we add in util/osdep.c.
> 
> V1 link:https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/
> 
> Changes in v3:
> - fix win32 build failure
> - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)

Sorry, I didn't see this and sent some comments against v2.
Though using _SC_OPEN_MAX was one of them, so that's nice.  :-)


r~

