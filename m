Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5B716A97
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42vc-0002Vp-DQ; Tue, 30 May 2023 13:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42vV-0002U9-Ll
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:14:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42vT-0000ld-Vl
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:14:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b024e29657so25316915ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685466866; x=1688058866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19xUmwucjlPlCbCbCkRgWpnQzK/vAbAewK+zBqhGe7Q=;
 b=umZL5zfBoWHxC58bly+zyP8bXYGy4/L8tUnD/6bTDVFNAl7zLbNI/QVEbJvafuEtT1
 44YMGsT/w/snNAs59V6L1EknsEhXZaSiadx/q6tmcenf03fB8VI8fFjKO8TYX9UuL+g0
 bDeQ2w5csi+76EgTFGeFnNgHDHVUzI3yP9r60p7CQWkCRpF6r14XU+gV4uI+UShECHwo
 jEs5uEvn/uj9ky/T1vrYMcWZQazC9blyX83KxCFND59f7njTjgG92DNIsSg9P5QS/NR3
 bBgHbpiIKu6VjFoiwiV43GD4fAfOzcHGV6yS2ArAVKkNWLPN543FgaO9U2pWLNnsrkTL
 1rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685466866; x=1688058866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19xUmwucjlPlCbCbCkRgWpnQzK/vAbAewK+zBqhGe7Q=;
 b=OPNlX92IgSZ+3uRSh5c+Og5bC+tSjRQOMAlhe1k3zWge1wsXGWuet9ZBNNWf4Kv3aW
 lym5WtGjBT5MDfVDOh1hfqV6ffP+9Ar5UVwO7bY9GhekWEg9L1UU13jOPxy4Y2QlSj4I
 BgPa9C1aqEQlMebRYCH6/4iDMVjsgKNoF2Uo4g0nhn+G5IYS5JSSEFEzQWyoKjO77dpv
 nyGySJ/SVmoJgtRqXmjweNHp/xZohZvUhW6VvWtuO1yh76MOW4VvlbJTj70qGkPsrF0r
 pmATr6HpdAltRLg9WBvZlYaF3RaMxB5EEBBeylCzWVbw1DT2GhCni9ih8nMmzuX+ockk
 7d5A==
X-Gm-Message-State: AC+VfDz5qaNJ4Dtap20p2LoD51Q3gU1UYxsyEXSdQfO22IKFgt8jwjz4
 OFHgynsxrP+8vJY2wfOZoMkRQQ==
X-Google-Smtp-Source: ACHHUZ7IiuRkmTQ9iFVEn5ZkRx2TUJzRMGJIicqnOcK8dO2LlR28OcN/5+rynlZ8t1XZ8ZD3o3LwjA==
X-Received: by 2002:a17:902:bb87:b0:1b0:26f0:4c8e with SMTP id
 m7-20020a170902bb8700b001b026f04c8emr2123392pls.69.1685466866386; 
 Tue, 30 May 2023 10:14:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a17090276c700b0019c13d032d8sm10536038plt.253.2023.05.30.10.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 10:14:25 -0700 (PDT)
Message-ID: <733e16a5-39a3-3807-d951-9029e2be7298@linaro.org>
Date: Tue, 30 May 2023 10:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only
 files
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-5-quintela@redhat.com>
 <60036a5c-920e-8407-e030-1dbc1008418b@linaro.org>
 <877cspwxxp.fsf@secure.mitica>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877cspwxxp.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/30/23 10:06, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 5/30/23 05:28, Juan Quintela wrote:
>>> This was the only caller for read only files.  So change the test for
>>> an assert in qemu_fflush().
>>
>>
>> Not a fan, as fflush(stdin) is well-defined.
> 
> I guess you mean this:
> 
>         For input streams associated with seekable files (e.g., disk files, but
>         not pipes or terminals), fflush() discards any buffered data  that  has
>         been fetched from the underlying file, but has not been consumed by the
>         application.

Yes, in that, importantly, it does not assert.

> 
> Two things:
> - Current code just do nothing for imput streams
> - We only call it from qemu_fclose()

Pardon?  There are nearly 30 calls to qemu_fflush.

> - If we drop anything from the input stream, migration get broken.

I'm not talking about dropping anything.  Obviously QEMUFile works different from stdio, 
and therefore resetting the file state to that of the unbuffered data is not relevant.



r~

