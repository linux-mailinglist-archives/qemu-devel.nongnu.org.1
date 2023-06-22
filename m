Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3D739ACE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCG3B-0007dZ-8j; Thu, 22 Jun 2023 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCG38-0007d3-My
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCG37-0003yG-6v
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687423936;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OfVWuDeTamkzakP2j/ChNPH3EqR5u7ALvUFlqoRXfjA=;
 b=cKV8jA57MtfqH6taJybZjAhLdv9b2hOozd0dg/qcTMCXcvki/YRrAlGTLPoc+uwYWnKI33
 JnUSfbmATK58sv4hSdFN6uVdBdyajaNGTpYf9Zx4lJFzUipn3j/clkXwymnDeJv7tsU2nB
 OLvi4kdeWbHcY/WWNd8mmLo1l/QIM28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-QPe3nBkUPHmUfMn6p23zKw-1; Thu, 22 Jun 2023 04:52:15 -0400
X-MC-Unique: QPe3nBkUPHmUfMn6p23zKw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3129fbfdea3so62758f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 01:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687423934; x=1690015934;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfVWuDeTamkzakP2j/ChNPH3EqR5u7ALvUFlqoRXfjA=;
 b=cD916X93fw23nhYfBPU4qjA9uoX28eLHZq/lMCE4IR4HQftcxQumNIGH1R3fko4uy9
 Wq0schtKDu8PAq90gCfXQr0/m49Oaj4S5QbLat/HqxklfeUb41ZYHe5bES0CIg9oLEVW
 CAYJ1LrN70lgR1XiM8cxoMiAkglqhhb+WG9jv0Gy6EJC6QX6yST4TUwmjN8+XQ3GLv5Q
 uKjOcnu+Z3bE91EnxtdShWPpKu13MtprmcANqg1x4C2c1Sehdp43CMpiFgpdcZviRnOH
 d7AP4iqjteMN++VYoIvHqJVFRJfvWnW0XPIU9CL7vNq42/lEsWy9vwod23cidh2mB/U6
 1p/A==
X-Gm-Message-State: AC+VfDxb3iHA1ao20YPN0RwtJEQuBrVgTyGFFFLYx9aDtAvWkdP21E5/
 c92rLNyD8qMnn0wHEIg3H1WxHBaSr0FaGnFxWj1b4z6UCYd9ggjkiz04yxw6+owU/EiaBk9FH94
 4KiGP+EkzUWR0o0Q=
X-Received: by 2002:adf:ec43:0:b0:30f:aef1:2add with SMTP id
 w3-20020adfec43000000b0030faef12addmr14836658wrn.47.1687423934112; 
 Thu, 22 Jun 2023 01:52:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OEbhJ7/3yF3/b5W8tlWnvf3yNchmfJHeL4Ei7zVuZTMtP4sCK1B/knKIwhMQs8sQrN9eFbQ==
X-Received: by 2002:adf:ec43:0:b0:30f:aef1:2add with SMTP id
 w3-20020adfec43000000b0030faef12addmr14836626wrn.47.1687423933715; 
 Thu, 22 Jun 2023 01:52:13 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 i15-20020a5d55cf000000b0030633152664sm6464817wrw.87.2023.06.22.01.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 01:52:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Thomas Huth <thuth@redhat.com>,  libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com> (Paolo
 Bonzini's message of "Thu, 22 Jun 2023 10:28:00 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 10:52:12 +0200
Message-ID: <87wmzv7ubn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 6/12/23 22:51, Juan Quintela wrote:
>>> Shall we just leave it there?  Or is deprecating it helps us in any form?
>> See the patches two weeks ago when people complained that lisen(.., num)
>> was too low.  And there are other parameters that work the same way
>> (that I convenientely had forgotten).  So the easiest way to get things
>> right is to use "defer" always.  Using -incoming "uri" should only be
>> for people that "know what they are doing", so we had to ways to do it:
>> - review all migration options and see which ones work without defer
>>    and document it
>> - deprecate everything that is not defer.
>
> "-incoming <uri>" is literally the same as running "migrate-incoming"
> as the first thing on the monitor:
>
>     if (incoming) {
>         Error *local_err = NULL;
>         if (strcmp(incoming, "defer") != 0) {
>             qmp_migrate_incoming(incoming, &local_err);
>             if (local_err) {
>                 error_reportf_err(local_err, "-incoming %s: ", incoming);
>                 exit(1);
>             }
>         }
>     } else if (autostart) {
>         qmp_cont(NULL);
>     }
>
> It's the only piece of code which distinguishes "-incoming defer" from
> "-incoming <uri>".
>
> So I'm not sure what the problem would be with keeping it?

User friendliness.

First of all, I use it all the time.  And I know that it is useful for
developers.  I was the one asking peter to implement -global
migration.foo to be able to test multifd with it.

The problem is that if you use more than two channels with multifd, on
the incoming side, you need to do:

- migrate_set_parameter multifd-channels 16
- migrate_incoming <uri>

And people continue to do:

- qemu -incoming <uri>
- migrate_set_parameter multifd-channels 16 (on the command line)

And they complain that it fails, because we are calling listen with the
wrong value.

> The issue is
> not how many features the command line has, but how they're implemented.

Or if they are confusing for the user?

> If they're just QMP wrappers and as such they're self-contained in
> softmmu/vl.c, that's fine.
>
> In fact, even for parameters, we could use keyval to parse "-incoming"

What is keyval?

> and
> set the parameters in the same place as above.  That would remove the need
> for "-global migration".

Could you elaborate?

The other option that I can think of is changing the error messages for
migrate_check_parameters() and give instructions that you can't set
multifd channels once that you have started incoming migration.
Explaining there to use migrate_incoming command?

Later, Juan.


