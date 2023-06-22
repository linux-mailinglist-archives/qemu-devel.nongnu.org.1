Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECCC7399B4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFfp-0000ZN-2V; Thu, 22 Jun 2023 04:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCFfl-0000Yw-47
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCFfj-0000y6-J2
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687422485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLqdyNno7Q2U7waosSbnuPWsZB+rpMGo3bAKBcoTUDc=;
 b=QKen59Lu83YKiAgjBgeHikogT3rMAXtyDDLNHA4En7d3dD5u0/rE5QfSLoH77LQXoSLBqW
 DXghD1SVz/lvk1MgOvxB+adVZAnMWB6HGKoCFzfD8zluIHlnNSiuQScfo3rQwJeIcuaXHQ
 aGc1M5iv1nwQWFFD9CxQVQzJocz1gmE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YptySSbcNhi6e_F2QIbK1Q-1; Thu, 22 Jun 2023 04:28:04 -0400
X-MC-Unique: YptySSbcNhi6e_F2QIbK1Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98277fac2a1so466666066b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687422483; x=1690014483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLqdyNno7Q2U7waosSbnuPWsZB+rpMGo3bAKBcoTUDc=;
 b=SCDSBHE+naHl5G/FvxiWhCX3C4+n4G7FA2I6SeYZCH7SqYRTSUA2nTLBcMJ41DT1ZG
 iYuk8kYteQU+B2Nhr2daVAcNReC2VnJck6aZxdNl278z6colfGoav2H39zl4sWjtJdps
 ofDFwGATOLBfgWGUTSLH8e5Gd46jb+EIyUz0KkaOJUxugHoKTKVjc1j50kPbuK4pZZHL
 mKHOSLTH9tKrkSWmhK/qb4WdQG+VG0zRJCzgyZGvmW0k67B57GoF+Ly/Ic2yNmk9gEyh
 BJNZbWGgGnkatimGhRginmn5fT8ThgR4VA55ZHymEH0eJ6yp+Kr1KkwM8w8MAwmk7vdA
 E/AQ==
X-Gm-Message-State: AC+VfDxY3jhJWWGLKq+YdseTHYvwt2oPtb+5izkz3kOCwaP420i5ik9l
 R6Nps4TnZmBarJg9woiQpmSZUR+ql+XY9H/BMvBzBIxESXx33beYX56m6LpC4gKxeTBpUluILvz
 4I979M5fgtxV+lVM=
X-Received: by 2002:a17:907:36c5:b0:978:acec:36b1 with SMTP id
 bj5-20020a17090736c500b00978acec36b1mr15349788ejc.17.1687422482867; 
 Thu, 22 Jun 2023 01:28:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CX+eeKYLOJPwfybxLRLnbEsYfat8gYOwkLenpbGS8Ha2BD0WVlQYdRRp3OyRRno4pmtR9Qw==
X-Received: by 2002:a17:907:36c5:b0:978:acec:36b1 with SMTP id
 bj5-20020a17090736c500b00978acec36b1mr15349776ejc.17.1687422482569; 
 Thu, 22 Jun 2023 01:28:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 w25-20020a170906185900b009890f2c4cf9sm4346749eje.79.2023.06.22.01.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 01:28:01 -0700 (PDT)
Message-ID: <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
Date: Thu, 22 Jun 2023 10:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Content-Language: en-US
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <875y7sflqb.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/12/23 22:51, Juan Quintela wrote:
>> Shall we just leave it there?  Or is deprecating it helps us in any form?
> See the patches two weeks ago when people complained that lisen(.., num)
> was too low.  And there are other parameters that work the same way
> (that I convenientely had forgotten).  So the easiest way to get things
> right is to use "defer" always.  Using -incoming "uri" should only be
> for people that "know what they are doing", so we had to ways to do it:
> - review all migration options and see which ones work without defer
>    and document it
> - deprecate everything that is not defer.

"-incoming <uri>" is literally the same as running "migrate-incoming"
as the first thing on the monitor:

     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
             qmp_migrate_incoming(incoming, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
             }
         }
     } else if (autostart) {
         qmp_cont(NULL);
     }

It's the only piece of code which distinguishes "-incoming defer" from
"-incoming <uri>".

So I'm not sure what the problem would be with keeping it?  The issue is
not how many features the command line has, but how they're implemented.
If they're just QMP wrappers and as such they're self-contained in
softmmu/vl.c, that's fine.

In fact, even for parameters, we could use keyval to parse "-incoming" and
set the parameters in the same place as above.  That would remove the need
for "-global migration".

Paolo


