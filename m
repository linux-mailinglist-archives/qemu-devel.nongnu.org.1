Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020FFA2C2D8
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 13:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNbK-0004bc-I6; Fri, 07 Feb 2025 07:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tgNbH-0004bD-US
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tgNbF-00011q-7e
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738931805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtS6MUQYBAgP5mlpzHtkqXazAG0CUcPyExaUVdCXkoM=;
 b=CDn93NBQlivIvy2UpH8VPYqeZqYPB8Lfq7IzJBjtUHC/jS3T+EKRC9t4YFtlzLtHGirTnQ
 3pbKD/s9k+XjQHXEgOz4C7tcZLIhnT08GGSlGmqCUjjCKE48TIUFWV5YJEeQb2/BfrNfY5
 DMFNqvT3PlRUFbBGRcS5kUqjD/6vrPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-HauemYHKNP6B75wK0A7-Mg-1; Fri, 07 Feb 2025 07:35:33 -0500
X-MC-Unique: HauemYHKNP6B75wK0A7-Mg-1
X-Mimecast-MFC-AGG-ID: HauemYHKNP6B75wK0A7-Mg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso11455335e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 04:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738931732; x=1739536532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vtS6MUQYBAgP5mlpzHtkqXazAG0CUcPyExaUVdCXkoM=;
 b=RiJ3/YVryjSncHgtJeyEqlQtx3ekGbaO8h0g/iOnGS/Waibe3lv3Mkp0FQ/Q9UIzQu
 8B0MGo6GcrOFYxXLRpM14s9GlNTVKTzVB/kCwCkv/X7WpgCJaogNXQ4CHiDsGHKd+ZYD
 xp8t07yscAM5KeaRAlIbJmvtYn6ET9ex9uo8gmotbfSTdTrIvuLbQKjeXnGJEDDPHa0I
 dp410vJwFQ8zqcSE9ATdjo8TDDG7qTB1kSEr1JbwK2V45rxn5AahCEzveeljZGSaeUwR
 wBLb+RQ/FbXCVxGF2qzusIuzCM3MvPvLajFbqD4Rr2tDuyutbg9uNr0Z29oxvAbnqJ1t
 lm+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYXvlzcanithz4giQ4DyJemufMvnah2cI7l48koISsvQcBqeQJfqkqcb8v5SETuvHcmJZ8OJkbtJrV@nongnu.org
X-Gm-Message-State: AOJu0Yz99Lk9sk24LebGEq7pe/P0Wf7yLhEd2H0L12uJNv9tzC2v/pZQ
 BxQiexGsCokSNKPTsossT6I6Ss2XFxmJUVlI+GFqrFauqOgmG5E3Df+FJKBHPADwVj8118WZPbR
 M3oYuKFKsGbcmsEOOqceLCtZuvwY6lRZFzY7yrpAgbua2nbjL8LjH
X-Gm-Gg: ASbGnctu3Db0FpYoVyvwgQPJVbCSJBMYCdwjq37jDtBzwb32udr2ZmoUwKAztYpQnaT
 CsArpPDRVP8A5AiVUkw6YTZ92b7Y3HTogUowaWRjEzc45+owTiTrGA3IIJiltj+Se84/QJQZSGW
 WkDR+QWjGED18MvCtJmZApLHn/nH02PGVYvqY+ATRdq15MPkCWt4/uR4+7GPv5yZk6NoiDL3cD9
 NNVJHbIu2wKID94Rts+WU5lpx4KZuHra1yBcCedo/fA9gSVorJ7+cSCzyiGbn4iFU8gD9ektxEM
 33caUEI1nA46HI1OjO1T2ex924biNN8pLTFb5hIjjupLCR6WfEWtwwMin9xk/ea6Wdx065OAmXj
 11TUaGSh6yeVOps6WFeWL7L7s+mTT3U3wVg==
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38dc9497d11mr1330962f8f.53.1738931732515; 
 Fri, 07 Feb 2025 04:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzlYHsLZVY/Yw4cQDwMbMt6y2d8TLcRrPFXM0BvcWOfIWrbMFNkzdlXAGp79CG+cvVsjsBBw==
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38dc9497d11mr1330899f8f.53.1738931730737; 
 Fri, 07 Feb 2025 04:35:30 -0800 (PST)
Received: from ?IPV6:2003:cf:d712:44fb:19ca:1c3d:6b27:934a?
 (p200300cfd71244fb19ca1c3d6b27934a.dip0.t-ipconnect.de.
 [2003:cf:d712:44fb:19ca:1c3d:6b27:934a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf35b15bsm668676f8f.64.2025.02.07.04.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 04:35:29 -0800 (PST)
Message-ID: <f3639df5-05cf-4aef-adfc-8a39ed7767ce@redhat.com>
Date: Fri, 7 Feb 2025 13:35:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 kvm <kvm@vger.kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, Akihiko Odaki
 <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.01.25 17:16, Stefan Hajnoczi wrote:
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> February 7th.
>
> About Google Summer of Code
> -----------------------------------------
> GSoC (https://summerofcode.withgoogle.com/) offers paid open
> source remote work internships to eligible people wishing to participate
> in open source development. QEMU has been doing internship for
> many years. Our mentors have enjoyed helping talented interns make
> their first open source contributions and some former interns continue
> to participate today.
>
> Who can mentor
> ----------------------
> Regular contributors to QEMU and KVM can participate as mentors.
> Mentorship involves about 5 hours of time commitment per week to
> communicate with the intern, review their patches, etc. Time is also
> required during the intern selection phase to communicate with
> applicants. Being a mentor is an opportunity to help someone get
> started in open source development, will give you experience with
> managing a project in a low-stakes environment, and a chance to
> explore interesting technical ideas that you may not have time to
> develop yourself.
>
> How to propose your idea
> ------------------------------
> Reply to this email with the following project idea template filled in:
>
> === TITLE ===
>
> '''Summary:''' Short description of the project
>
> Detailed description of the project that explains the general idea,
> including a list of high-level tasks that will be completed by the
> project, and provides enough background for someone unfamiliar with
> the code base to research the idea. Typically 2 or 3 paragraphs.
>
> '''Links:'''
> * Links to mailing lists threads, git repos, or web sites
>
> '''Details:'''
> * Skill level: beginner or intermediate or advanced
> * Language: C/Python/Rust/etc

=== Asynchronous request handling for virtiofsd ===

'''Summary:''' Make virtiofsd’s request handling asynchronous, allowing 
single-threaded parallel request processing.

virtiofsd is a virtio-fs device implementation, i.e. grants VM guests 
access to host directories. In its current state, it processes guest 
requests one by one, which means operations of long duration will block 
processing of others that could be processed more quickly.

With asynchronous request processing, longer-lasting operations could 
continue in the background while other requests with lower latency are 
fetched and processed in parallel. This should improve performance 
especially for mixed workloads, i.e. one guest process executing 
longer-lasting filesystem operations, while another runs random small 
read requests on a single file.

Your task is to:
* Get familiar with a Linux AIO interface, preferably io_uring
* Have virtiofsd make use of that interface for its operations
* Make the virtiofsd request loop process requests asynchronously, so 
requests can be fetched and processed while others are continuing in the 
background
* Evaluate the resulting performance with different workloads

'''Links:'''
* virtiofsd repository: https://gitlab.com/virtio-fs/virtiofsd
* virtiofsd’s filesystem operations: 
https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/passthrough/mod.rs#L1490
* virtiofsd’s request processing loop: 
https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/vhost_user.rs#L244

'''Details:'''
* Skill level: intermediate
* Language: Rust
* Mentors: Hanna Czenczek (hreitz@redhat.com), German Maglione 
(gmaglione@redhat.com)


