Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634F75F84C
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvcO-0003yS-Pf; Mon, 24 Jul 2023 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNvcM-0003yH-L9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNvcL-0007uP-4Z
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690205332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztoUJJ0VnnJnTfBx7cdvmu8Hiaanr+P6qC3bbwGK8Zk=;
 b=Nrq37vM0sNI5iRG7AhGO7PHWXUj6v6GhKuD7/RbIWKxxpnUhScSkYOm9hZW2I+xHgaawMK
 +2r386TqJsvoX8ds4gLEEO5Yt57vbVjvXpNcUSml/+u7PO4q6G+a5NzxJGNGheCs+/RQ0g
 e0y1thFrYZFU+8gHagHEsccEa/kRdz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Jt0a0btbPZ6Y0UdXPMBcng-1; Mon, 24 Jul 2023 09:28:51 -0400
X-MC-Unique: Jt0a0btbPZ6Y0UdXPMBcng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fc07d4c2f4so26924165e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690205329; x=1690810129;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztoUJJ0VnnJnTfBx7cdvmu8Hiaanr+P6qC3bbwGK8Zk=;
 b=cBG5F5/1MwE2huCJjxKBJzMPKDdzMH4RbxiICibT4ms2Elg3SpzHTwRjdYIw1PqEMJ
 SdYW0aGjzDiaj8jbBRj8zZGyRN/LwHe3NzCf8btQfa2aQXrEXJXeIOBo05aXPDxPQvSt
 bvyj7j6jqhudwy4uq2OHZzredUVRtwl5qkIwtZMGl3VoDrP+YXwvlTBCzP26HEW2s3If
 dKqe/IUWBD2hn5WFRtvMEJCVjrHdYbbLTQKMJXaj9z/rtXlzaiBmO7hlkatmc1eKR6Tv
 c0MnYOvXP4ap0VxM7bWtkgHxe7CxI72RBRn8ljXqSyVctswcFe4brBYHeMdc5nFaJIvj
 TfEw==
X-Gm-Message-State: ABy/qLZ/IbubtazPhaUmnSVdoipAtl+cM1YGR9V1gkZ0UBlZm42u6e+l
 8gjjl9wwiDY8ijl/OMQ1Cyw3CduFVNe04EGf2tdIZxwvRSXoKionyR+auM2O1qNIhB1OWOJ4W+2
 IoJJB9WBWyhjq1Bs=
X-Received: by 2002:a7b:cd87:0:b0:3fb:fef3:53f8 with SMTP id
 y7-20020a7bcd87000000b003fbfef353f8mr7261096wmj.25.1690205329807; 
 Mon, 24 Jul 2023 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2igVJfxUoqxuKMsSntzC3A4fMtqM8+8keloCJdALCRPHO3kxMvafsbeTR0pvyn5O8g9n+0A==
X-Received: by 2002:a7b:cd87:0:b0:3fb:fef3:53f8 with SMTP id
 y7-20020a7bcd87000000b003fbfef353f8mr7261082wmj.25.1690205329502; 
 Mon, 24 Jul 2023 06:28:49 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 f12-20020a7bcc0c000000b003fc0062f0f8sm10507543wmh.9.2023.07.24.06.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 06:28:48 -0700 (PDT)
Message-ID: <30ff28d1-abc5-a416-b44e-59abd3881fa4@redhat.com>
Date: Mon, 24 Jul 2023 15:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 00/26] Migration PULL 2023-07-24
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 24/07/2023 15.06, Juan Quintela wrote:
> Hi
> 
> This is the migration PULL request.

Maybe it would better to use "PULL" instead of "PATCH" in the subject?

> Now a not on CI, thas has been really bad.  After too many problems
> with last PULLS, I decided to learn to use qemu CI.  On one hand, it
> is not so difficult, even I can use it O:-)
> 
> On the other hand, the amount of problems that I got is inmense.  Some
> of them dissapear when I rerun the checks, but I never know if it is
> my PULL request, the CI system or the tests themselves.

I normally peek at https://gitlab.com/qemu-project/qemu/-/pipelines to see 
whether the problem occurred in one of the last staging CI runs already ... 
or I push the master branch to my own repo to see whether it reproduces with 
a clean state. That often helps in judging whether it's a new problem or a 
pre-existing one.

> This (last) patch is not part of the PULL request, but I have found
> that it _always_ makes gcov fail.  I had to use bisect to find where
> the problem was.
> 
> https://gitlab.com/juan.quintela/qemu/-/jobs/4571878922
> 
> I could use help to know how a change in test/qtest/migration-test.c
> can break block layer tests, I am all ears.
> 
> Yes, I tried several times.  It always fails on that patch.  The
> passes with flying colors.

Can you reproduce it locally by running "make check-block"?

The tests/qemu-iotests/tests/copy-before-write test seems to be doing some 
things with snapshots ... maybe that's related?

  Thomas


