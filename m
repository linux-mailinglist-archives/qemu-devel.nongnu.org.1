Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBA7DE250
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:23:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyC7s-0007vI-TH; Wed, 01 Nov 2023 10:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyC7o-0007uz-Gr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyC7m-0000As-Tt
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698848593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quJpnbVrnx3quzb1U0BKh9zyA+CNI313t6z1dOg+uHw=;
 b=R5tzf3hqzHxGrxueyA9rIfhc33TlsuL61NujsyZhhnIr/L4SgyDYypBV3SWkcR8e504rLT
 Bm4V+7yOaiWVXrJ6T10pdIP79tZiDhZzKL4w/GrUuysT68SeSZNqVMfxyTTitnBnN7NC2G
 LsmxtrCyS+o+e5zpU7wKzzA+DuQbV44=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-6ptHnqGGPTKEQXReQU5oyw-1; Wed, 01 Nov 2023 10:23:07 -0400
X-MC-Unique: 6ptHnqGGPTKEQXReQU5oyw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so5062216a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698848586; x=1699453386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=quJpnbVrnx3quzb1U0BKh9zyA+CNI313t6z1dOg+uHw=;
 b=WRjsn1eRncQHcuDIhBVe3yYkxATLMnnN+FA7tIeVkoGnT9e7BS9wQJ+Xh/QKxUXtJl
 oTIBYKAXILDEclsjJCVW970m+KQCjEyiqyi2jun9JwmofCdSNfLWe7A+eLJVE9OCoPf1
 8zpIvfRdrOr5bE22hbCho2kOVhqHe3fyR6FeZ+HwQhXBoQdMrlAqKjn3mfGyzLsJkSmF
 iKEDiZe4myMqguC2Rrzxn47WZXl/ltgZ+XWfgBuY1fgB0sij7E4rLSDa98tF25tO8wzv
 16Y4TA/oCGkfLM7R3YT2P8BpOxdvYxZcnpeqe8N7Q+0/R42VulLdurSA7NRR6vJ1aOQ8
 WROw==
X-Gm-Message-State: AOJu0Yzp22xXqBmSx0TLDMWseC2v9iqTGlstVOGLhEHhljF9gJT4R+nh
 Aa6wsis2q8L1Srp8X/ZsuxiPVZ6/GeOl/DqVaMgXd2nEsLPe3g4eYHi0xKPuVEs/kEx+40L/b/A
 YEVPC5k+WtAewgLc=
X-Received: by 2002:a05:6402:1bc4:b0:53e:3b8f:8a58 with SMTP id
 ch4-20020a0564021bc400b0053e3b8f8a58mr12495119edb.11.1698848585866; 
 Wed, 01 Nov 2023 07:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtJlEhQWzzdpcNEQ8Eehxj+S99+HdjxTqN2TaMX2K2pDvrQ9q7FD98UMchFFeSYi8C6nM5dQ==
X-Received: by 2002:a05:6402:1bc4:b0:53e:3b8f:8a58 with SMTP id
 ch4-20020a0564021bc400b0053e3b8f8a58mr12495107edb.11.1698848585514; 
 Wed, 01 Nov 2023 07:23:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 u7-20020a056402064700b0053f9578ec97sm1128259edx.56.2023.11.01.07.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 07:23:04 -0700 (PDT)
Message-ID: <eed79d9c-822b-4c27-b9cb-d43cd92ee1c1@redhat.com>
Date: Wed, 1 Nov 2023 15:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qio: add support for SO_PEERCRED for socket channel
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-2-aharivel@redhat.com> <ZUImaz5rK/ltE4ex@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZUImaz5rK/ltE4ex@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/1/23 11:20, Daniel P. Berrangé wrote:
> On Tue, Oct 31, 2023 at 03:46:01PM +0100, Anthony Harivel wrote:
>> The function qio_channel_get_peercred() returns a pointer to the
>> credentials of the peer process connected to this socket.
>>
>> This credentials structure is defined in <sys/socket.h> as follows:
>>
>> struct ucred {
>> 	pid_t pid;    /* Process ID of the sending process */
>> 	uid_t uid;    /* User ID of the sending process */
>> 	gid_t gid;    /* Group ID of the sending process */
>> };
>>
>> The use of this function is possible only for connected AF_UNIX stream
>> sockets and for AF_UNIX stream and datagram socket pairs.
>>
>> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
>> ---
>>   include/io/channel.h | 20 ++++++++++++++++++++
>>   io/channel-socket.c  | 17 +++++++++++++++++
>>   io/channel.c         | 12 ++++++++++++
>>   3 files changed, 49 insertions(+)
>>
>> diff --git a/include/io/channel.h b/include/io/channel.h
>> index 5f9dbaab65b0..99c02d61c3d9 100644
>> --- a/include/io/channel.h
>> +++ b/include/io/channel.h
>> @@ -149,6 +149,9 @@ struct QIOChannelClass {
>>                                     void *opaque);
>>       int (*io_flush)(QIOChannel *ioc,
>>                       Error **errp);
>> +    void (*io_peercred)(QIOChannel *ioc,
>> +                        struct ucred *cred,
>> +                        Error **errp);
> 
> This isn't going to fly. 'struct ucred' is Linux specific, so this won't
> compile on macOS, Windows, *BSD, and we don't really want a huge #ifdef
> ladder in these APIs. This will need to explode the struct and return
> the individual fields that are present instead, and the impl side must
> compile on other OS, even if its just stubbed out to return an error.

I would further reduce it to to io_peerpid, because the BSDs can only 
provide the peer uid and gid.

Paolo


