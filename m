Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464F781A18B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 15:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFxwF-0001ub-6S; Wed, 20 Dec 2023 09:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rFxwC-0001sz-3o
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 09:52:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rFxw1-00011u-8i
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 09:52:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c39ef63d9so62486295e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1703083949; x=1703688749; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ibG6vmzkWlhTmqyuSp3GHp8mv5e6cQE5qos9D6b1g9M=;
 b=Mmts6GKQeu96o77idYNJwW1S9NkuAmfkMUTb7MZrxLkhvdGJG/iAmZdS+xIwTZRv9g
 KQDla4Kk37s8SDi1KeRk+MZv7/VN/2jk77QCHDkEZ+wZKKt2cTUpSG3IdmI/bfyjAVF2
 2hZsPHpFSptLW0Gt9rcrk97y5BAX9ix8ZDxzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703083949; x=1703688749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibG6vmzkWlhTmqyuSp3GHp8mv5e6cQE5qos9D6b1g9M=;
 b=k4T0cARfdAPOrF9T7cuFqAbG5OEnLH3xb0XfRSr+el92Z2/RF8Je8dr3lJ+JswVlXP
 97BJ5M9JOym1MsCi01df5p0E4HknqRXT1jPP1AuW3Ei+wwCBGzDjXjosb4ui+vHGoDAS
 HQ8iO2kMo9Kkuu6iccFkMfR7w/d3tnE1ZzV2a6IAsqa0pKNlnktEjV9YcurQ+mYpcvK7
 rUIRnxMsT6YMfgg+sTM0lJxia5NY7sxEWn56FIgk+33eI7N1l1a+uCwoHwIICslxwvyd
 N2xD47Kjc4iIyZYcdt79CUTi0xbfLqmWet/amtymFabER244Vbkl4Vbmh8tpDI2WirF2
 qQVg==
X-Gm-Message-State: AOJu0YwVzuJmdG0t4beRwJcM2hQOz6Y6XXAgsWd3ssGsToleUEpuizWY
 MdnD10SOgK7RMnohn0M8eXgljg==
X-Google-Smtp-Source: AGHT+IHra2LBpOzjyYRCLwOYefyNfnE3n7jHzwLXNvsHQ3CXBTrecv1U4UzTfEHyz9BCJfNhE8JaKg==
X-Received: by 2002:a7b:c849:0:b0:40c:a5d:860d with SMTP id
 c9-20020a7bc849000000b0040c0a5d860dmr10259294wml.169.1703083949322; 
 Wed, 20 Dec 2023 06:52:29 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c444e00b0040c58e410a3sm7815235wmn.14.2023.12.20.06.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 06:52:28 -0800 (PST)
Date: Wed, 20 Dec 2023 14:52:27 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH V8 00/12] fix migration of suspended runstate
Message-ID: <04583cf1-8172-49be-81b0-adb88d6f9808@perard>
References: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
 <a9ddc1b2-d4fc-44de-857b-2aeb35fa0925@oracle.com>
 <ZX_VS_KDsoiL9T2X@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX_VS_KDsoiL9T2X@x1n>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Mon, Dec 18, 2023 at 01:14:51PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2023 at 10:35:33AM -0500, Steven Sistare wrote:
> > Hi Peter, all have RB's, with all i's dotted and t's crossed - steve
> 
> Yes this seems to be more migration related so maybe good candidate for a
> pull from migration submodule.
> 
> But since this is still solving a generic issue, I'm copying a few more
> people from get_maintainers.pl that this series touches, just in case
> they'll have something to say before dev cycle starts.

I did a quick smoke test of migrating a Xen guest. It works fine for me.

Thanks,

-- 
Anthony PERARD

