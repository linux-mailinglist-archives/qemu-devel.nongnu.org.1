Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF471FDF9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51BX-0008K8-61; Fri, 02 Jun 2023 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q51BV-0008Jj-18
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q51BT-0007Eq-Im
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685698499;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZybqPCLqR0C+7Qp8kJzjvg6I4/mkw/fxaMFn+u5JJbM=;
 b=gp7FAS+mL2Cb/h7W7Ze0tT5AMks8+Xlgx7uKYjqbBOGVM7oRrsMET+bXPmdUBhE4ENlM2D
 DN3JBtBwNICjcaiRQ/El9oONRJxsrdizmPorLuMWHeVXe3rualZa3ogDnXTCfPoDU1UUes
 XVhycaxtIJ9DneVXfrXllgzEy802wlg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-8Mizf5UIO2GNHBXU3gs0CA-1; Fri, 02 Jun 2023 05:34:55 -0400
X-MC-Unique: 8Mizf5UIO2GNHBXU3gs0CA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f3bb23174eso1918105e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685698494; x=1688290494;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZybqPCLqR0C+7Qp8kJzjvg6I4/mkw/fxaMFn+u5JJbM=;
 b=cG84DxnIlbQV2fXfabQx4a3vbthkcStJst5DTNz/A/y0j7aZ2XgQeTrIVJOskWCRQX
 QCC4zPqAssduncJA4Qp8K5andTVgQBaSx7q75XyyyLoOqWYK5IrV9Ij8L0kXxu7xC8FP
 hRK77f2MtNiszgTeUtRcPpBGJE24RcQw2+6yqPJCWT6D+ntpfefg1pZ2ReeMR7SmxJpL
 23JmslzWSJo0bQhqADGUKZCx3jZqB1hvBQNJow1AzfgoMLxBstCwP5kxqfHY/B8KQxgG
 1RJoGyshm3gXNCkd/T0Git2T3U/yiK3fKXtqtBOUKcthO7awCjaieFLCuvBoxG9fBQ1Z
 29xg==
X-Gm-Message-State: AC+VfDzgH/8NCXId+ZCP/FW8l+naW9iZfoLM4XTesFKyIqV8LgYaiCap
 JGohD2QLiThj/SC7Gpz5BA8e+C+3gMrj1YyF4ecPpZWghK/znwp/Q2zJz6HJUssUb8jhHAY9ZiM
 SvMKTZqzZ3BbU5qU=
X-Received: by 2002:a2e:8853:0:b0:2b0:4f4d:1cd with SMTP id
 z19-20020a2e8853000000b002b04f4d01cdmr1296964ljj.15.1685698493982; 
 Fri, 02 Jun 2023 02:34:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zb43v4JdR0AZuxlXpSgSq3FkitwlNb1MoZa8SmCHE14kGt7e2n3FdQyhveSeLFxRPAfim/Q==
X-Received: by 2002:a2e:8853:0:b0:2b0:4f4d:1cd with SMTP id
 z19-20020a2e8853000000b002b04f4d01cdmr1296957ljj.15.1685698493669; 
 Fri, 02 Jun 2023 02:34:53 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b003f4266965fbsm4961092wmh.5.2023.06.02.02.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 02:34:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 peter.maydell@linaro.org,  Richard Henderson <rth@twiddle.net>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: Big TCG slowdown when using zstd with aarch64
In-Reply-To: <ae4540a2-f4d1-aece-d1e5-d631d9814233@redhat.com> (Thomas Huth's
 message of "Fri, 2 Jun 2023 11:24:00 +0200")
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
 <ae4540a2-f4d1-aece-d1e5-d631d9814233@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 11:34:52 +0200
Message-ID: <87leh2p5qb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> On 02/06/2023 11.10, Daniel P. Berrang=C3=A9 wrote:
> ...
>> IMHO this feels like just another example of compression being largely
>> useless. The CPU overhead of compression can't keep up with the guest
>> dirty workload, making the supposedly network bandwidth saving irrelevan=
t.
>
> Has anybody ever shown that there is a benefit in some use cases with
> compression?

see my other reply to Daniel.

Basically now a days only migration over WAN.  Everything over a LAN or
near enough LANS, bandwidth is so cheap that it makes no sense to use
CPU to do compression.

> ... if not, we should maybe deprecate this feature and
> remove it in a couple of releases if nobody complains. That would mean
> less code to maintain, less testing effort, and likely no
> disadvantages for the users.

For multifd, I don't care, the amount of code for enabling the feature
is trivial and don't interfere with anything else:


(fix-tests-old)$ wc -l migration/multifd-z*
  326 migration/multifd-zlib.c
  317 migration/multifd-zstd.c
  643 total

And that is because we need a lot of boilerplate code to define 6
callbacks.

The compression on precopy is a complete different beast:
- It is *VERY* buggy (no races fixed there)
- It is *VERY* inneficient
  copy page to thread
  thread compress page in a different buffer
  go back to main thread
  copy page to migration stream

  And we have to reset the compression dictionaries over each page, so
  we don't get the benefits of compression.

So I can't wait the day that we can remove it.

With respect of the multifd compression, Intel AT data engine (whatever
is called this week) is able to handle the compression by itself,
i.e. without using the host CPU, so this could be a win, but I haven't
had the time to play with it.  There are patches to do this on the list,
but they are for the old compression code, not the multifd ones.  I
asked the submiter to port it to multifd, but haven't heard from him
yet.

Later, Juan.


