Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AC7FD92B
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:23:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8LRi-0004RC-UO; Wed, 29 Nov 2023 09:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8LRf-0004Qs-WD
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:21:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8LRe-0000PE-Dg
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:21:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3331974c2d2so399051f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701267700; x=1701872500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vuotNsSJ3mz1jNM/jv3owEo6FFWm28DP4IxuqSJZKw=;
 b=PDoDwB8cXVOBBNiA1K5uIB2/TJOtpR2VPdSUTT8fTtyoKJLbHs0y/51vF6Tt4S/tBH
 wuIyYiF2EM8JVf+whLB7+Yn6Lo7WLuy0uQDqKzmS1cC6kj+JpUbJYTMD8AMfQlaqAY5D
 yNg4nm+d3zRLJ9GbLpWQaTdhNS/OcIPTopV0uD/Cj2+RrhH1IFPO5av7q4FdZJ/z78Ke
 jbKgx/uR20+Mf7kEcdUaNhL97QATIAV9k1/Nj2y9/hIxqbyMxFiYUT2mQNWPgYA6ziz7
 eMtcsQI7VhlCCz/b4hA2CGu9XMA7jw8bwBlHFv6sOS9JWedekOSTJcmg2nxUAeXX7FIv
 lF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701267700; x=1701872500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vuotNsSJ3mz1jNM/jv3owEo6FFWm28DP4IxuqSJZKw=;
 b=mkDXhGrVLjCN1CrvM3C2rxNrY5LwYa9SyWHirCmy+EGxqFjUjI3AKAiK/mK1lawxyW
 mibBkVWnqGZHf77ZatQxeps+d88Jw6QWT524DkKMkxNVe3cslK2NzpbgCPGzVDV5iwem
 zBuC7eZjt2RPs0qm8b54WFvaDjmArFfTe716+84CBkRO7NAADtLJtmHbFYqz8HCsaNd1
 3ieEDt+wbFoSLbOJn9zkgBbVug3NfZdqh0omOUv8gr+9GK6dtoRrVdM054ZnLQOSZJEu
 TqseOPm/sUgsmQSBYLkV7fv3iXgRoRqkt9eKHEkqWzCNiz/seCemrfu+6SwOQPeuL9MY
 7olg==
X-Gm-Message-State: AOJu0YxoBQ2I89SYwUk6Q+P+do3VTv50QVt4eX5IhjtayqmtyKr5h//e
 6lu41wR+ipSY3D6Zr/cG9DRjFQ==
X-Google-Smtp-Source: AGHT+IFqeZh1YFbYeNJ9ddNynhGdnVFpSRjEfbTycUACdaywiTZ+s9rue+IIoWve9gWLABYFY3GUhg==
X-Received: by 2002:a5d:64c5:0:b0:333:17cb:c3d0 with SMTP id
 f5-20020a5d64c5000000b0033317cbc3d0mr1810559wri.64.1701267700103; 
 Wed, 29 Nov 2023 06:21:40 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-250.dsl.sta.abo.bbox.fr.
 [176.184.16.250]) by smtp.gmail.com with ESMTPSA id
 2-20020a5d47a2000000b00332ff137c29sm9913338wrb.79.2023.11.29.06.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 06:21:39 -0800 (PST)
Message-ID: <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
Date: Wed, 29 Nov 2023 15:21:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Summit Minutes 2023
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZWYsMsgxjDZ_T2zA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 28/11/23 19:06, Daniel P. Berrangé wrote:
> On Tue, Nov 28, 2023 at 06:54:42PM +0100, Cédric Le Goater wrote:

> Anyway, when a maintainer wants to merge a tree, I would expect to
> have a MR opened against 'master' in qemu-project/qemu.  The CI
> ought to then run and if it is all green, then someone would approve
> it to merge to master.
> 
>> It seems to me that we should also have a group of people approving
>> the MR.
> 
> Yes, while we could have one designated gate keeper approving all
> MRs, that would defeat some of the benefit of MRs. So likely would
> be good to have a pool, and also setup the config so that the owner
> of an MR is not allow to approve their own MR, to guarantee there
> is always a 2nd pair of eyes as sanity check.

Are all our tests already on GitLab? Last time I remember Peter still
had manual tests.

