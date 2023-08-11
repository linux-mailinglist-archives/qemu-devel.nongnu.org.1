Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9EC7791EA
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:32:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTB4-0007h0-NU; Fri, 11 Aug 2023 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUTB2-0007gj-6u
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUTAz-0005BH-Vv
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691764300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAu0N5iH7cwLG9PaOs5911gjlHQ7uzUYsDHva3GiYDs=;
 b=KLFyAmrCrf2DKXLexOp27Na+m5kMg7DPkDZHdiu2KGLM5bYD1di7naYWPzYzR5SHyL0gpx
 PvAC4d6cBeaPjio+aHgZSQTlRMve7d8jGCFvAhtBAsv3O5TlQmtrx+5/65xrb8sr4auis4
 t6Nbs9BwcOZeifrXQiK+V/r1k/Pa8QQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-RC9AncgPOJ20DvD2Y-tZ2g-1; Fri, 11 Aug 2023 10:31:39 -0400
X-MC-Unique: RC9AncgPOJ20DvD2Y-tZ2g-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-56ccec776feso359060eaf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691764298; x=1692369098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAu0N5iH7cwLG9PaOs5911gjlHQ7uzUYsDHva3GiYDs=;
 b=OBoo5wFvpFZ2OATJ5nSJOrRqo6PkXx4c4YJBc/dFIdwiQrX+F4D05z3M+wvAHBAAF+
 uzLb+hM1o0a5GmmqqvmcdawaI+gSlHb2xLhKNcFmWCPJWPl/88ITcAtApedXHNllPyes
 xooP1AjLX5xFM5bvmyuZ1+lJflugI/lPZ0Qtb3Xlk0XmWVVOJ3w63fY43H7XFggKnh2q
 pT18UyshQ6oJdUBaX24tX1t2wwmxCgj2O5/tw+pUj3QWAyrzWitGrRrYi8IlkfnCrThH
 Lh4kjvWBeQh+/GmtIGcyvUedb3tPQW8Fdta/ObMmeXN+6dx+cq059JGIVw9ZbLfPNTcg
 ITVg==
X-Gm-Message-State: AOJu0YzotlkthDm4e5eaWbuF3rToHAVkvgA1x6tK1k2usO5weTqcs4FX
 +sgu1JHbB0fDzOIHrHVr/1QJgT4s96y2kkjHfGAJKXCK27mFjnC9NYRdiui2TfpEtd5fMZSAzZj
 28mY0Xp/DbWk89NE=
X-Received: by 2002:a05:6358:c60a:b0:134:d3bc:f24 with SMTP id
 fd10-20020a056358c60a00b00134d3bc0f24mr1496898rwb.0.1691764298115; 
 Fri, 11 Aug 2023 07:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExxn7xcvqXVBoO6YSut03dbsuz41BD997hbuO49mX5hPkrExUdJQhDuhCRKH3seRnFrSu4sg==
X-Received: by 2002:a05:6358:c60a:b0:134:d3bc:f24 with SMTP id
 fd10-20020a056358c60a00b00134d3bc0f24mr1496886rwb.0.1691764297767; 
 Fri, 11 Aug 2023 07:31:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h11-20020ac8744b000000b00403ad6ec2e8sm1202483qtr.26.2023.08.11.07.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 07:31:37 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:31:36 -0400
From: Peter Xu <peterx@redhat.com>
To: ThinerLogoer <logoerthiner1@163.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: Re: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening
 guest RAM file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNZGSON+yDFod2AZ@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 11, 2023 at 01:49:52PM +0800, ThinerLogoer wrote:
> At 2023-08-11 05:24:43, "Peter Xu" <peterx@redhat.com> wrote:
> >On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
> >> >I think we have the following options (there might be more)
> >> >
> >> >1) This patch.
> >> >
> >> >2) New flag for memory-backend-file. We already have "readonly" and 
> >> >"share=". I'm having a hard time coming up with a good name that really 
> >> >describes the subtle difference.
> >> >
> >> >3) Glue behavior to the QEMU machine
> >> >
> >> 
> >> 4) '-deny-private-discard' argv, or environment variable, or both
> >
> >I'd personally vote for (2).  How about "fdperm"?  To describe when we want
> >to use different rw permissions on the file (besides the access permission
> >of the memory we already provided with "readonly"=XXX).  IIUC the only sane
> >value will be ro/rw/default, where "default" should just use the same rw
> >permission as the memory ("readonly"=XXX).
> >
> >Would that be relatively clean and also work in this use case?
> >
> >(the other thing I'd wish we don't have that fallback is, as long as we
> > have any of that "fallback" we'll need to be compatible with it since
> > then, and for ever...)
> 
> If it must be (2), I would vote (2) + (4), with (4) adjust the default behavior of said `fdperm`.
> Mainly because (private+discard) is itself not a good practice and (4) serves
> as a good tool to help catch existing (private+discard) problems.
> 
> Actually (readonly+private) is more reasonable than (private+discard), so I
> want at least one room for a default (readonly+private) behavior.

Just for purely discussion purpose: I think maybe someday private+discard
could work.  IIUC what we're missing is an syscall interface to install a
zero page for a MAP_PRIVATE, atomically freeing what's underneath: it seems
either punching a hole or DONTNEED won't suffice here.  It'll just be
another problem when having zero page involved in file mappings at least.

> 
> Also in my case I kind of have to use "-mem-path" despite it being considered
> to be close to deprecated. Only with this I can avoid knowledge of memory
> backend before migration. Actually there seems to be no equivalent working after-migration
> setup of "-object memory-backend-file,... -machine q35,mem=..." that can match
> before-migration setup of "-machine q35" (specifying nothing). Therefore
> I must make a plan and choose a migration method BEFORE I boot the
> machine and prepare to migrate, reducing the operation freedom.
> Considering that, I have to use "-mem-path" which keeps the freedom but
> has no configurable argument and I have to rely on default config.
> 
> Are there any "-object memory-backend-file..." setup equivalent to "-machine q35"
> that can migrate from and to each other? If there is, I want to try it out.
> By the way "-object memory-backend-file,id=pc.ram" has just been killed by an earlier
> commit.

I'm actually not familiar enough on the interfaces here, but I just checked
up the man page; would this work for you, together with option (2)?

        memory-backend='id'
                An alternative to legacy -mem-path and mem-prealloc options.  Allows to use a memory backend as main RAM.

                For example:

                -object memory-backend-file,id=pc.ram,size=512M,mem-path=/hugetlbfs,prealloc=on,share=on
                -machine memory-backend=pc.ram
                -m 512M

-- 
Peter Xu


