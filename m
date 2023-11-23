Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E37F5B14
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 10:30:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6620-0000RU-V8; Thu, 23 Nov 2023 04:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r661y-0000RG-T6; Thu, 23 Nov 2023 04:29:54 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r661x-0000Uz-B3; Thu, 23 Nov 2023 04:29:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-332d5c852a0so411568f8f.3; 
 Thu, 23 Nov 2023 01:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700731791; x=1701336591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uUwE7u3onPGssHGYPcJFRGaN2UI16fqtGIi4M3Ht1a4=;
 b=dCMuBMXx6YFclGb6lTltYnaPsuXDksVwndphsqxNYOGoorCsOE3nn4FL0tzSj9/RcY
 uvbKvpGAcVT9qN80ypb5hT2DDxEBJ6lUm4ZZu+DhjmJ0hbCWbLuyCcnqC2bdlbtf9rnE
 52yyJxDNXPbYGIk4FCjXB12onsvUnovN7e7tpacRS9eZ2dYqQafvGMVVnarEpwUhumE5
 XsUge00yUKtBe7fKO8/bbYzhCXao2jcxzLKu6HhDwVLKtKWrGbq2cXqe9UjktoDUaaHW
 6f2ZKSgXCIHuCc0pmT/OTb+Rv11//JJn9YGgh7OA9Wt8xLUEOoB2XBmao9LQe7n66+qD
 i6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700731791; x=1701336591;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUwE7u3onPGssHGYPcJFRGaN2UI16fqtGIi4M3Ht1a4=;
 b=uiHCF3EoZl5zBEIRr7rtobHbm/TdOoSEd7wowRZZd+i/OgMy0UVyIZOlMf+P1y6D4W
 1/RDqWLPyZGsUWGE/p/P12Bj9DX9UH4KieTiptMP34mBJi/4bYyx+2sTPzacwdJO6FXI
 8xPlnOfr8KmEqxOVlq04wd5BANMXd9J/cMClZf1VtfZWo7CQCKqur5iT6Xcd3TsO4TJg
 ieLs4JWNLEqHJBdufuWXKY9ERwGdm570MtsOS2r5kVNgR2XalG/aJHJrC+E1USN7cVh8
 Wi9XIYGMzDCqDxUT+MuVmagJx3ZnP1ixHfTAmtiOeRPxZHBfQCcqjSv5F+B02KnEcwr0
 9lnQ==
X-Gm-Message-State: AOJu0YzItygY2i0G+fjhpBTtZkOQZ+1YiLidrNkGPloan283kPWYdt4c
 aim/sBfWGK6AZfPaEKIWrTI=
X-Google-Smtp-Source: AGHT+IFlygPZqpcnr3ZfDt4tmxZcvFNUOiDOTe0AZd7sdtL0/KrfYErVCG8BikAxQK6z7g+6mdxvPQ==
X-Received: by 2002:a5d:4bc6:0:b0:32f:b1ab:ee87 with SMTP id
 l6-20020a5d4bc6000000b0032fb1abee87mr3685763wrt.25.1700731791454; 
 Thu, 23 Nov 2023 01:29:51 -0800 (PST)
Received: from [192.168.13.100] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adf978f000000b00332d41f0798sm1133102wrb.29.2023.11.23.01.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 01:29:51 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <630819c4-4343-401d-8c7b-342cfd5f50c0@xen.org>
Date: Thu, 23 Nov 2023 09:29:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/xen: Set XenBackendInstance in the XenDevice
 before realizing it
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-2-volodymyr_babchuk@epam.com>
 <e1663064-247d-41e3-9a36-16f81303fb94@xen.org> <878r6p1jp2.fsf@epam.com>
 <67e06eae161072e05f4b0990dbde1da869241670.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <67e06eae161072e05f4b0990dbde1da869241670.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42e.google.com
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

On 22/11/2023 23:04, David Woodhouse wrote:
> On Wed, 2023-11-22 at 22:56 +0000, Volodymyr Babchuk wrote:
>>
>>
>> Paul Durrant <xadimgnik@gmail.com> writes:
>>
>>> On 21/11/2023 22:10, Volodymyr Babchuk wrote:
>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>> This allows a XenDevice implementation to know whether it was
>>>> created
>>>> by QEMU, or merely discovered in XenStore after the toolstack created
>>>> it. This will allow us to create frontend/backend nodes only when we
>>>> should, rather than unconditionally attempting to overwrite them from
>>>> a driver domain which doesn't have privileges to do so.
>>>> As an added benefit, it also means we no longer have to call the
>>>> xen_backend_set_device() function from the device models immediately
>>>> after calling qdev_realize_and_unref(). Even though we could make
>>>> the argument that it's safe to do so, and the pointer to the unreffed
>>>> device *will* actually still be valid, it still made my skin itch to
>>>> look at it.
>>>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>>>> ---
>>>>    hw/block/xen-block.c         | 3 +--
>>>>    hw/char/xen_console.c        | 2 +-
>>>>    hw/net/xen_nic.c             | 2 +-
>>>>    hw/xen/xen-bus.c             | 4 ++++
>>>>    include/hw/xen/xen-backend.h | 2 --
>>>>    include/hw/xen/xen-bus.h     | 2 ++
>>>>    6 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>
>>> Actually, I think you should probably update
>>> xen_backend_try_device_destroy() in this patch too. It currently uses
>>> xen_backend_list_find() to check whether the specified XenDevice has
>>> an associated XenBackendInstance.
>>
>> Sure. Looks like it is the only user of xen_backend_list_find(), so we
>> can get rid of it as well.
>>
>> I'll drop your R-b tag, because of those additional changes in the new
>> version.
> 
> I think it's fine to keep. He told me to do it :)

I confirm that :-)

