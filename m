Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91D803781
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:50:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAHO-0008OK-Vg; Mon, 04 Dec 2023 09:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rAAHM-0008KA-BK
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:50:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rAAHK-0005qt-Gk
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:50:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40bd5eaa66cso29757505e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701701432; x=1702306232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QuFxYfCQgGqyDlmipQJ9xAOvctGkAf1KGLHtYl2aWIs=;
 b=IrrS7qE9idACOdb6aywZ4svc2CUokJ9g7NNNqaxye96g82ekGhR9gZ1zwwXWiScOky
 5o3uwSnwTwWCvcFgFQ0X8k0P47iENNP1seZs7AKWM/7PtXf1jribIn8xa7KhXTfdGaMz
 wl7kNUhuo6Fa5W/JwejIM3DHkvzHPLcDlWFJZLnXG8JECBw3kPqtBB8Mn/3S3QfdADmc
 5m50A+h3YyRWLWJbb4LNOqLnaruKpqDTyJlDynfLHtyiGrdcmu+iwXtY15Ho7OUVbbpD
 M0NQAUt9bPB/OvS8zcKriO4+YJpGiY97jTnHwYMSQOaawI4XXnSAc8TxppsvVUGlVDgU
 1qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701701432; x=1702306232;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuFxYfCQgGqyDlmipQJ9xAOvctGkAf1KGLHtYl2aWIs=;
 b=W3yksMdT4OGDsKIiY9L0VO8VIehds302Wh/F5lVIRYzVl1tKyBXQUZI0FMoBwoq0iE
 lDwAKg1SC3+lctl81tYHGoPe1cyVd1c1f7ckPNILZ1WeVRYi4CFJTYU0s51l2Lrt9X6k
 V0VRj/sz5sdrZPf9dUqye4CaE/Id1DjbqYijQJoyqvqqohACm5/7WtZxDpjNbBnnfGqq
 wmqvaVVELSllBbs/1s8MC/Irc3zQL349vsjtEWv90Tw0amagAtZKUkrAfiHUMicFJaXn
 IpV8SDgtm3lwUsIPFJDoYpC0zrugp0CGsin7FDZEfcdwCxkRDfUurU6emPJPWlT14taW
 X8DA==
X-Gm-Message-State: AOJu0YxKDtQixUFq8KX27Jpm/AUqx1NVuFpxnAzz88KY9IUdE5yy4lF4
 +spOTtzg+idQGU0kZ6qYjV0=
X-Google-Smtp-Source: AGHT+IF21sWOb6KsB5O/DUFH/HjWdwEv6jhyxSjG9c7CR7UGAYutJWZUg8JZwLoPIYHj8tpXXVAIfA==
X-Received: by 2002:a05:600c:acd:b0:40b:38a8:6c65 with SMTP id
 c13-20020a05600c0acd00b0040b38a86c65mr1942181wmr.26.1701701432222; 
 Mon, 04 Dec 2023 06:50:32 -0800 (PST)
Received: from [192.168.17.187] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b0040b501ddd34sm18955384wmq.48.2023.12.04.06.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 06:50:31 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <07817159-7516-44e8-aee0-f3f6330b2b6f@xen.org>
Date: Mon, 4 Dec 2023 14:50:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] xen: decouple generic xen code from legacy
 backends codebase
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
 <20231202014108.2017803-4-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231202014108.2017803-4-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
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

On 02/12/2023 01:41, Volodymyr Babchuk wrote:
> In xen-all.c there are unneeded dependencies on xen-legacy-backend.c:
> 
>   - xen_init() uses xen_pv_printf() to report errors, but it does not
>   provide a pointer to the struct XenLegacyDevice, so it is kind of
>   useless, we can use standard error_report() instead.
> 
>   - xen-all.c has function xenstore_record_dm_state() which uses global
>   variable "xenstore" defined and initialized in xen-legacy-backend.c
>   It is used exactly once, so we can just open a new connection to the
>   xenstore, update DM state and close connection back.
> 
> Those two changes allows us to remove xen-legacy-backend.c at all,
> what should be done in the future anyways. But right now this patch
> moves us one step close to have QEMU build without legacy Xen
> backends.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
> In v4:
> 
>   - New in v4, previous was part of "xen: add option to disable legacy
>   backends"
>   - Do not move xenstore global variable from xen-legacy-backend.c,
>     instead use a local variable.
> ---
>   accel/xen/xen-all.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


