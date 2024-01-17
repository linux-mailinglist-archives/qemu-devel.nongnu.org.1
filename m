Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB083074E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:47:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6FC-0002yo-8y; Wed, 17 Jan 2024 08:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ6F8-0002yT-Ns
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:46:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ6F6-0006UJ-RE
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:46:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e884de7b9so10126505e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705499165; x=1706103965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzyST0bHdGvKXDXS+1NV82M3RXDr7fYd29+mTloRgfM=;
 b=EuPFvpOnk8pRJbvOzBFEv/u9Na5hIzn35iKsO21Cm+k4uEXRO2QcOqlOBXjcnnrMj7
 ox+wjfcXIzwMW573RnohhlbrQHd06pCIa6bqmWcqLQppJlfzUjIGdYgA3GUtrpXnDLnS
 KgYRcjP3n3aiV5WbDGk5VuQq3jaSOi1DNQnTQEUHnMaVIW+GvA0TAU2JChYSiBAzukE4
 ed2pFd/fZofNQr9aW0bKQQKVgXdpfrlUdiHf28/jxLwOJT7NLBKhyDk7zVOHkc8fcMTd
 XhLWJmXBD0Ym11XImeOcbc5zXfXwwdsUG2NzQToQEGpgyNZ4op7CbRZabhKdVclMVqcB
 KI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705499165; x=1706103965;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lzyST0bHdGvKXDXS+1NV82M3RXDr7fYd29+mTloRgfM=;
 b=wuwk/jUD0m3VTRB2jNxKyMZlpoPUs9Xf6rKXDfHXRq0Eah8jiC/ztdq2KRPb3hA1PE
 iLUB1vDRUycx95OAqLBhmOUhqZ/ht9N4IKs/TWKSwB4dMUjftgt2OX5GLqTsC6J3T9v0
 RFcNFt3cQFWjNkd9yFZ9/zsX7E3ccgYgpvGz+yW1k3Lgz3WtmR4oeN74QImfjHHJ7l9g
 zydf+8JJmuK4NCNCSNlRZ+LNNIFRoZ266gD1NBXL0bKiTHXBWe17mWChZrNIJ3KXifE6
 BZWiL3X7tH5VtSBbOJ0Tj4Y2WbIRZgb5zr1jHJeXL39SzSwncLMsdvpEPCATu1+XQ+8n
 w+UA==
X-Gm-Message-State: AOJu0YyWRcVFutM2qACHBN1ovfY1aXQfl4fW0zkUrRNDp3ZuF1zfnq2e
 C++WUSlW6VPZTRyu9dUKNDye+AWzeYgPzg==
X-Google-Smtp-Source: AGHT+IELLkAdPAep4nJJzOgZLYCjX2RGpb46n3eEw7iaEfgV+vCR/RkEqBcBfcnCIwVaXb/8JkfKKg==
X-Received: by 2002:a05:600c:4686:b0:40e:5332:4062 with SMTP id
 p6-20020a05600c468600b0040e53324062mr4284962wmo.33.1705499165261; 
 Wed, 17 Jan 2024 05:46:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b0040e8bf3c9a9sm1642480wmq.21.2024.01.17.05.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 05:46:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F5645F79E;
 Wed, 17 Jan 2024 13:46:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  qemu-s390x <qemu-s390x@nongnu.org>,  David
 Hildenbrand <david@redhat.com>
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
In-Reply-To: <feb272b1-4729-4acf-8feb-5aed993a5a06@tls.msk.ru> (Michael
 Tokarev's message of "Wed, 17 Jan 2024 14:53:35 +0300")
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
 <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
 <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
 <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
 <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
 <e1f48ff4-d640-4500-9f2b-6b9db0d8ffe3@linaro.org>
 <5c3098cc-3a2f-4272-b06a-6d12d645d628@linaro.org>
 <feb272b1-4729-4acf-8feb-5aed993a5a06@tls.msk.ru>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 13:46:04 +0000
Message-ID: <87mst4hy3n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 04.01.2024 01:51, Richard Henderson :
>> On 1/4/24 01:37, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Finally changing the constraints on op_rotli_vec seems to fix it:
>>>
>>> ---
>>> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
>>> index fbee43d3b0..b3456fe857 100644
>>> --- a/tcg/s390x/tcg-target.c.inc
>>> +++ b/tcg/s390x/tcg-target.c.inc
>>> @@ -3264,13 +3264,13 @@ static TCGConstraintSetIndex tcg_target_op_def(=
TCGOpcode op)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_ld_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_dupm_vec:
>>> +=C2=A0=C2=A0=C2=A0 case INDEX_op_rotli_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return C_O1_I1(v=
, r);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_dup_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return C_O1_I1(v=
, vr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_abs_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_neg_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_not_vec:
>>> -=C2=A0=C2=A0=C2=A0 case INDEX_op_rotli_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_sari_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_shli_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_shri_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_s390_vuph_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INDEX_op_s390_vupl_vec:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return C_O1_I1(v=
, v);
>> Definitely not correct, since VERLL requires a vector input to be
>> rotated.
>>=20
>>> But I'm outside of my comfort zone so not really sure what I'm doing...
>>> (I was inspired by the "the instruction verll only allows immediates up
>>> to 32 bits." comment from
>>> https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg317099.html)
>> That message is confused.=C2=A0 The immediate in VERLL is 12 bits (with
>> only 6 bits ever used for MO_64).=C2=A0 Dunno where "32 bits" comes from.
>
> So, what do we have here in the end?
> Should we fix this on qemu side?

I think the thinking is we should disable the optimisation for the 8.2
stable while figuring out the true fix for 9.0.

>
> This thread stopped quite some time ago, with problematic
> instruction found but no solution..
>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

