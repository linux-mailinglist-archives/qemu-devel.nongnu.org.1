Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BACE7CE051
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7nn-0007Gv-BM; Wed, 18 Oct 2023 10:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7ni-0007BQ-RP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7nd-0002O5-O4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697640327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PFi5WCONJLvDXkZ3j4GAR7+4LdCUZUtlmr86Reh/XOQ=;
 b=R4J1HNokqtjqhTSdLwvUJwmVp2u+QoJHl72vN4EjN3cj94W2YsaSagk23laIvJVL2Vz/0A
 MPviPBjWO63ZHCiOZvB3Y/oso6aGus6w2P8r33lYSmGjl1LUJed25yVn6c0afX11o8IK+m
 7FXWqvVyZct4L8D3qFNXvxqEMP8APZ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-22b-FsQ8P9e_mOHdZQ_DVQ-1; Wed, 18 Oct 2023 10:45:26 -0400
X-MC-Unique: 22b-FsQ8P9e_mOHdZQ_DVQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so44185275e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697640325; x=1698245125;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFi5WCONJLvDXkZ3j4GAR7+4LdCUZUtlmr86Reh/XOQ=;
 b=bv0kDtnfjbggLr/iwIi9W4JMLoU2cDEbFQTVkLo8Jqd6Qt79+X0oluTVoSFg80znOB
 H96kKAABX2d126hqwyoLAWLf8IncHDt/nTd+32T4NgRtaeJqMtk8tYXE4h1lsNzTl2yT
 0zVmqO0OUXfNW8Xy9V9rZAtl8zFTqiJD8nuDEFoNysnfp5ES4AzqGAOfL4wdLf9R2izt
 dBltSxrKBaRLXK5a4dtPLFB3fy3gm30pYaXhIqnNbIligDrNHhpiWbeaJtoX+49NcCJL
 s1xaZwhFqJdT3rlNrgLIPwGRCe7iGhrSqDUgtXc/u88nzZt5ep9lH0XBHZhNNdyZesvu
 qfYA==
X-Gm-Message-State: AOJu0Yz0TS5SjyZ3XElRDrZIJjUXmEJBxbPr2S4jTX2INa4fnXfuL57U
 jFRRYY1i1AIS/A95vdLdq4MgVN3NZhlMhNagElmE0O+ZVnbyEtop0hOfBsA+4U7x089FfSANbwE
 T+EGwK0o4I7+HlNg=
X-Received: by 2002:a5d:67ca:0:b0:31f:98b4:4b62 with SMTP id
 n10-20020a5d67ca000000b0031f98b44b62mr4733539wrw.37.1697640324961; 
 Wed, 18 Oct 2023 07:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYWm4diFgNVmphDQWC9k3aE/2tu8GMCcyr5HKuTWbUf5TRGbk3ZE9flhTFxIejIP61xtqQIg==
X-Received: by 2002:a5d:67ca:0:b0:31f:98b4:4b62 with SMTP id
 n10-20020a5d67ca000000b0031f98b44b62mr4733521wrw.37.1697640324653; 
 Wed, 18 Oct 2023 07:45:24 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f5-20020a056000128500b0032d2f09d991sm2259488wrx.33.2023.10.18.07.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:45:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 10/11] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <87edhsdmkt.fsf@suse.de> (Fabiano Rosas's message of "Wed, 18 Oct
 2023 11:36:34 -0300")
References: <20231018140736.3618-1-farosas@suse.de>
 <20231018140736.3618-11-farosas@suse.de>
 <87edhs80u5.fsf@secure.mitica> <87edhsdmkt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 16:45:23 +0200
Message-ID: <875y347zwc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>> D> We have strict rules around migration compatibility between different
>>> QEMU versions but no test to validate the migration state between
>>> different binaries.
>>>
>>> Add infrastructure to allow running the migration tests with two
>>> different QEMU binaries as migration source and destination.
>>>
>>> The code now recognizes two new environment variables
>>> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
>>> either of them, the test will use the QTEST_QEMU_BINARY variable. If
>>> both are missing then the tests are run with single binary as
>>> previously.
>>>
>>> The machine type is selected automatically as the latest machine type
>>> version that works with both binaries.
>>>
>>> Usage:
>>> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
>>> QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
>>> ./tests/qtest/migration-test
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> The test works for me.  But I would really like to be able to specify
>> the machine type for which I have to test.  I.e. right now, we can test:
>>
>> qemu-8.2 <-> qemu-8.1
>>
>> and it is going to use q35-8.1
>>
>> But in the case that I want to test that two binaries with q35-8.0,
>> there is no way to setup that.
>
> Sorry, I didn't catch that you wanted to test versions other than the
> latest when you mentioned it the first time.
>
>> So basically what I need is
>>
>> QTEST_QEMU_MACHINE_TYPE var, and if that exist, just use that instead of
>> the value of "machine"
>>
>> What do you think?
>
> I don't see why not.
>
> I have to resend this series because I sent the wrong version by
> accident. I'll add the new var then.

Thanks.


