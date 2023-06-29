Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FCC742352
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEo0I-0005lx-A7; Thu, 29 Jun 2023 05:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEo0G-0005kH-0Z
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEo0E-0008Np-AI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688031109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DK0Mgz++EIwBrtQB2GuH3ImqD8HNyhWA2GmAVIwvqHY=;
 b=Ar2cRhpKUCqOmDgyhGQUY2lPFD/CmAsog11AsfeUPenLCij/FdtYte6dJPL7j8zMh66vMp
 SYTH6saeqTUx7UxrLfkEXrmK5JjQbL1PCQBoEe774y6cqn8W0Xr8uTk2sC7mR10usreHnd
 Uh7X4OyA8PEvoWl8LmZafXLjg+mrv+0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-tyqytX7lMiCruLLXPWqJNQ-1; Thu, 29 Jun 2023 05:31:45 -0400
X-MC-Unique: tyqytX7lMiCruLLXPWqJNQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f956a29f2aso448154e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688031104; x=1690623104;
 h=content-transfer-encoding:in-reply-to:subject:from:references:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DK0Mgz++EIwBrtQB2GuH3ImqD8HNyhWA2GmAVIwvqHY=;
 b=ZS+q2VUcJSuJXJTUUZ9LZkkVtXgGnyMsghtWR2eOb6aPjZwaKGQNZCK6xtpQZQxGv8
 I7iTNJg2c1c1ECdG+erb30j5A5+bHda21faiudHVhg0tHOMNeG++cV+oBl9APDyZxvtl
 8JchHXuili/pGDffc4CaOMnTwH8xUXfT1hq9oNb+wHOUnO/gwrKhw3gpRcL0KyQ9kbHJ
 o4qsScKzJW26aFU168Eo7z4itYNn1/MziuJXqFLOxVDti8Jp9UR2jwljCTsfw8s4UFQN
 ixPaHbRWQiQ9SGInsn14syeNlxrCgFDFj3YBbYUjiemapOtv4mIPuniNVf3pKPN0GLr1
 m2CA==
X-Gm-Message-State: AC+VfDy50RrBi3vO/LfUAqv8+pHb5SIgPavgkkCpnYBZMb8hlghngWOF
 6/nozZVWP8txx/PEIRXVrmXRO4aNPLU7kdlarX0OGNjJwKng8JEKpij4Aez5f6K4XVrf/+M0yiK
 C6cCaVDFwRMS4GbA=
X-Received: by 2002:a05:6512:455:b0:4fb:8939:d962 with SMTP id
 y21-20020a056512045500b004fb8939d962mr4643472lfk.19.1688031104073; 
 Thu, 29 Jun 2023 02:31:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GnspaboBoWxjfz8chKFbd26wksdMOAB+8vckm+b81eyLlvigA3/aiTKqv5P/iFyaBg9jHMg==
X-Received: by 2002:a05:6512:455:b0:4fb:8939:d962 with SMTP id
 y21-20020a056512045500b004fb8939d962mr4643465lfk.19.1688031103775; 
 Thu, 29 Jun 2023 02:31:43 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b003fba80535a5sm6517411wmi.24.2023.06.29.02.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:31:43 -0700 (PDT)
Message-ID: <1f0afdee-09f0-83a5-f8fb-d2b86827ba16@redhat.com>
Date: Thu, 29 Jun 2023 11:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20230629080234.179687-1-thuth@redhat.com>
 <305b3e1f-aa55-8efe-8394-7c1b90ffe3f3@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] Fix installation instructions for Debian/Ubuntu
In-Reply-To: <305b3e1f-aa55-8efe-8394-7c1b90ffe3f3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/06/2023 10.12, Michael Tokarev wrote:
> 29.06.2023 11:02, Thomas Huth wrote:
>> There is no package called "qemu" here - thus use the two meta-packages
>> "qemu-system" and "qemu-user" instead.
> 
> There are 2 questions here.
> 
> 1. Do we really want to suggest users to install the whole thing?
> qemu-user and qemu-system are two entirely different beasts, used
> for entirely different purposes.  This is exactly the reason why
> I dropped `qemu' package from debian/ubuntu, - because effectively
> there are two independent, entirely different packages.
> 
> Also 1.a, - again, whole qemu-system usually isn't needed. There are
> another 2 big different classes here, - native thing (probably with
> kvm), and foreign thing.
> 
>> Resolves: https://gitlab.com/qemu-project/qemu-web/-/issues/8
> ..> -* <strong>Debian/Ubuntu:</strong> `apt-get install qemu`
>> +* <strong>Debian/Ubuntu:</strong> `apt-get install qemu-system qemu-user`
> 
> 2.  There are 2 qemu-user packages on debian/ubuntu: it is qemu-user
> and qemu-user-static. My guess is that most users actually need the latter,
> at least this one lets to run foreign chroots without copying anything from
> host system to a chroot.  In rare cases when one wants to install and run
> foreign binaries directly into the host system, qemu-user is okay. But it
> is a really rare case, and usually combined with running foreign chroots
> anyway.
> 
> So I'd say this whole thing needs a bit more explanation, like,
> 
>   when you want to run qemu-system emulation, install qemu-system 
> (meta)package.
>   when you want user-mode emulation, install qemu-user-static package.

Ok, thanks, makes sense, I sent a v2 where I've split it.

> This is actually a question to QEMU upstream, - I think the same reasoning
> applies there as well.

Looking at our docs, it seems like we're lacking an introduction to the the 
"configure" switches like --enable-system and --enable-user completely, 
indeed :-(

  Thomas


