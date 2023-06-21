Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1514173907E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC414-0007fI-3t; Wed, 21 Jun 2023 16:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC412-0007ew-BY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC410-0002h0-0Y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687377675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JC/0xRoE8YEw0WeqBhd/slwuZDgJcVYDaChP+3idk0=;
 b=RO7fe0BYIVgvVo6coT1Eq67VMN0oX9wO4xGXxaoMnIXKOPT/TPEomNkUj0Cl+fAzOhZu0M
 EaNKHxVsBkJycWrsB0SvFp9ZJGiG7tHR3pptV5ABNsSqr2Kv8CPjG2Mtn8DKllVVCqIWgB
 /1Bt/R+08hhGmu1edkkeL2Yd+AKr/eY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-7w3e58lbPjqi8ajZ8NBn7g-1; Wed, 21 Jun 2023 16:01:12 -0400
X-MC-Unique: 7w3e58lbPjqi8ajZ8NBn7g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-631e9a9e92bso6573726d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687377661; x=1689969661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JC/0xRoE8YEw0WeqBhd/slwuZDgJcVYDaChP+3idk0=;
 b=eNJK9LTf5uKDEYsWVnvDbFgwSLaGdNqFD+EaUKYxXvn6K/DIQ02C2CP0TkwNK3U3W3
 h8cccQs3LSoK0ze5UB0A/RdRhg9woALEcpvQgLOdGy9MH6csbqnUMWWzCvSKfzVXOzdT
 1aU72gNmnZjLrIGAmoRO4gXf8Hq3ri1+ToHkA01QIHR1MC7CHCtypC/vbQPnSHtuUPgI
 rA3d+u6to0C7OnJU3eYe0si9wWD1vyF+HFA2nJU43w28jTWyAm1chDK6UzBKO18/jNAw
 hbY/t3wYsB0K1HauyPY1lj0oflb7sXyqgxqXMLDm8DeMKMz4bxKGgzSlgPV/2JPlf5Ja
 xGCg==
X-Gm-Message-State: AC+VfDw4vpG6K5kwMZlhuGC83RXASBNCpmsNSdOrdfOALFsF+sN7LdrP
 SqBX7MHrnJFGW0Byhw+sxTPlhStZC9TIDfhFFZoUg3kBpwdSnifk/R8FKYX6dGOqCmT/PWeVFKD
 xMYYzsRMr+4htGCY=
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id
 kj24-20020a056214529800b0062f12836185mr19899186qvb.2.1687377661143; 
 Wed, 21 Jun 2023 13:01:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56FCNR0gCFsnWyt+eqPq7FXWFyao0vglmdZTONx0VIxo1DN+/6zvmXN+urDCYelCrTc0LYHQ==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id
 kj24-20020a056214529800b0062f12836185mr19899164qvb.2.1687377660834; 
 Wed, 21 Jun 2023 13:01:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t2-20020a0cde02000000b0062fede81d0asm2787296qvk.144.2023.06.21.13.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 13:01:00 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:00:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 3/3] tests/qtest: live migration suspended state
Message-ID: <ZJNW+2RsId/gbEQ6@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
 <ZJMpFfetFkZ/QjfT@x1n>
 <e848fa92-3cfe-a3bc-d666-625e72a65518@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e848fa92-3cfe-a3bc-d666-625e72a65518@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 21, 2023 at 03:39:44PM -0400, Steven Sistare wrote:
> >> -        jmp mainloop
> >> +        # should this test suspend?
> >> +        mov (suspend_me),%eax
> >> +        cmp $0,%eax
> >> +        je mainloop
> >> +
> >> +        # are we waking after suspend?  do not suspend again.
> >> +        mov $suspended,%eax
> > 
> > So IIUC then it'll use 4 bytes over 100MB range which means we need at
> > least 100MB+4bytes.. not obvious for a HIGH_ADDR definition to me..
> > 
> > Could we just define a variable inside the section like suspend_me?
> 
> No, because modifications to this memory backing the boot block are not
> copied to the destination.  The dest reads a clean copy of the boot block
> from disk, as specified by the qemu command line arguments.

Oh okay, can we use HIGH_ADDR-4, then?  I just still think it'll be nice if
we can keep HIGH_ADDR the high bar of the whole range.

Thanks,

-- 
Peter Xu


