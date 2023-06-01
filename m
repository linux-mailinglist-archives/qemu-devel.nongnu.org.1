Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBB571952E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:16:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dT3-0000X6-Bt; Thu, 01 Jun 2023 04:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4dT0-0000Wf-Jh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:15:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4dSy-0007zp-Bg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:15:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5149b63151aso870702a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685607325; x=1688199325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=viWKEUUHS4zdQ/HzjMwOcYT22BWS+ZHjvsrR+uT6aoA=;
 b=ecIrfa93aMW+vNFnY0V6h6NH7tGS7jjxV0dVfOsOujEQA2zW+Rx6193u8L+5tUoYIg
 ZurihPqV76zOwuo3Zh3abUwwYoym/4DXUcYmXN4AJp4dqe5GGAFCOqoO06PT9h6GH2/d
 zAR/aQt5gsvswJzva/F6yNzTf5seI2Gdr4sdSXf+PnZLt/+OtxczxlJo9YlVy4GUXwC8
 Wqq8OBrL1ZVYa8i9HJ8CtmwTrnubppA1MVDh3jYWYmAeXoJOeyuvxZlPp68m10lpCQJr
 E7STmtFeOA97O707lMDfSsr9cAPTYWDsYssDw9eeYC7UR2ob4EHk6igT5TUVJ6ok26F/
 /mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685607325; x=1688199325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=viWKEUUHS4zdQ/HzjMwOcYT22BWS+ZHjvsrR+uT6aoA=;
 b=MmX8LTKebuHBS9PsVGES4SpFmL0zofgR8/Er8lsAF9+ysUu3gu/44VyjXSvUFxBA/T
 4LSCGPW/s1oANuYNuhWt4sdKMqrx+TVpYeONAyJ2cagyQtXDP2RuYeG2g21RgmvZvFcj
 13fGpfCtOiOA2DvJzv4QYJxRz7AxREDCQ16EncWT3jZm2p9rMYP+kK6ewyxYMDa9yr/w
 OjyyAEDEY+4kXaY/UjESYkFv6pNr7ar2jfYbk2v/X7/8nM5KxC75wPBIyEnzyrmOv607
 gWY8hP8t+hx7gSvfzue88U8bwNxAoA0RcyaobP7HqsS9XGvkEPzl8DK+iM4pmbgTc5Oe
 EX2g==
X-Gm-Message-State: AC+VfDy+6XFCLjtXs08AQCevLFzLER26Ig0Bstm9PP1M4oWO7gfi/cCN
 SkJGlwXTzhfkbQ9YgYcCkvYwCA==
X-Google-Smtp-Source: ACHHUZ7XD4o0bYbCEQtBbRHRLlkBhWJ/0bdVFZ2SKTHZ81MVZwmHHh7Z/eA7HTLGha/sMe+WRff+KA==
X-Received: by 2002:aa7:c995:0:b0:514:94ff:f67e with SMTP id
 c21-20020aa7c995000000b0051494fff67emr5497923edt.5.1685607324751; 
 Thu, 01 Jun 2023 01:15:24 -0700 (PDT)
Received: from [192.168.8.135] (095-097-139-014.static.chello.nl.
 [95.97.139.14]) by smtp.gmail.com with ESMTPSA id
 y24-20020aa7d518000000b005149e90115bsm4782538edq.83.2023.06.01.01.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 01:15:24 -0700 (PDT)
Message-ID: <5aca924f-ca01-a3b4-41fc-e4896f297f6b@streamhpc.com>
Date: Thu, 1 Jun 2023 10:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
 <20230531162446.2bc9a26c.alex.williamson@redhat.com>
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230531162446.2bc9a26c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=robin@streamhpc.com; helo=mail-ed1-x532.google.com
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



On 6/1/23 00:24, Alex Williamson wrote:
> On Wed, 31 May 2023 23:55:41 +0200
> Robin Voetter <robin@streamhpc.com> wrote:
>> Something that I have been thinking about, are there any implications
>> involved with enabling this feature automatically with no possibility of
>> turning it off? I have no use case for that, though, and I cant really
>> think of a reason other than preventing the guest from finding out
>> hardware details about the host.
> 
> Not sure I follow, are you suggesting that Atomic Ops completion
> support is proactively enabled in the VM to match the host, regardless
> of attached assigned devices?  An obvious problem there is migration.
> If I start a VM on a host with Atomic Ops support and want to migrate
> to a host without Atomic Ops support, config space of the root ports is
> now different and the migration fails.  QEMU would also require
> elevated privileges to read config space to determine the host support,
> and then what does it do if only some of the PCIe hierarchy supports
> Atomic Ops.
> 
> Policy decisions like that are generally left to management tools, so
> there would always be a means to enable or disable the feature.  In
> fact, that's specifically why I test that the Atomic Op completer bits
> are unset in the root port before changing them so that this automatic
> enablement could live alongside a command line option to statically
> enable some bits.
> 
> That does however remind me that it is often good with these sorts of
> "clever" automatic features to have an opt-out, so I'll likely add an
> x-no-rp-atomics device option in the next version to provide that.

Yes, something like that that is exactly what I was thinking about.

Thanks,

Robin Voetter

