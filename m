Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E87CC775
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslzn-0005Vw-RH; Tue, 17 Oct 2023 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qslzl-0005Vm-JM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qslzk-0006tp-60
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697556511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6amoe/Ipy3MhdectxxgPvEA+Hc08xDwKFF/7iWvqL0=;
 b=XR1u2JbnG0XluTLtim0OKqW43qzx8bjEcgNIoALMij/32APXiHmYP5vNIkY6lbeY+j2Bho
 Zupu4xb4vxIouCNdQh6zf3YFi7QF9n2ZZJWfHzukm17kNnZI9RWlWJj1BSxQayttkdo/nR
 AbmMIQSK2Qt4UqQ6Pd95BOCsWUvGe+I=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-uJlNOLNGPUOWqAkkAErIHw-1; Tue, 17 Oct 2023 11:28:20 -0400
X-MC-Unique: uJlNOLNGPUOWqAkkAErIHw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-58165739b64so1450282eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697556499; x=1698161299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6amoe/Ipy3MhdectxxgPvEA+Hc08xDwKFF/7iWvqL0=;
 b=WvGIElgyUOyY4jzrQJo9pYaTA3hQJseI9RzrVx3istHx9c60Oz72I3OMgCupdD/bTV
 SzZdzbG76KGyPZ6R53nBf0Pp0wtcH0Ebi1PhvLJ03wsV6Xjq9mQhnqROPVqkShjYVSjz
 d6WmXjEzKHff/sW8GrMx/tkKgWuDhYm2MUEemsqqbggE41SkXq/lXK+CDbUUK/jwpfl7
 tHiKsmYSaRkPpt4C0Hah0qEZwFSidr7uUG6px3J2rupjtrgsAEC8eVFZutBJUQMUjjVD
 bQVZl/Vr0n1tplb1+rzU5PHdcPz3ah6qXdJu8fGrbr3XFB1eJv8HFm8Tip1LiuMivGFL
 SMXA==
X-Gm-Message-State: AOJu0YxSjd6dpQj6f2+Dtw/wu0+LUu6JGnoOlLPxZVmD8wgHCOVWLGZo
 p5DbqLetr48s0CiBECyFFcYtQ9Gip0434lh368MttOL8IKCYGXCPQfhC6oKq51lSUY3qpR/dQns
 fNRFqH9iBegy4UV0=
X-Received: by 2002:a4a:d898:0:b0:581:84e9:a7ad with SMTP id
 b24-20020a4ad898000000b0058184e9a7admr2518296oov.1.1697556499499; 
 Tue, 17 Oct 2023 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA4LoVqiHwrTbGn2HrgKjIBKUq/yl1fJrFtWJGrBbasnSfQqtOF+cdMh3EzXgOpLgXflApKA==
X-Received: by 2002:a4a:d898:0:b0:581:84e9:a7ad with SMTP id
 b24-20020a4ad898000000b0058184e9a7admr2518284oov.1.1697556499215; 
 Tue, 17 Oct 2023 08:28:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d12-20020a37c40c000000b0076d6a08ac98sm740493qki.76.2023.10.17.08.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:28:18 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:28:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter objects
 and fix tls-authz crash
Message-ID: <ZS6oEPZfd/JFG58X@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <87h6mqixya.fsf@pond.sub.org> <ZS1k3mBVHgIPrjfO@x1n>
 <87v8b5dajh.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8b5dajh.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 17, 2023 at 08:32:02AM +0200, Markus Armbruster wrote:
> I can see two useful QAPI generator features:

Agreed.

> 
> * Improved handling of missing member documentation
> 
>   Problem: many members lack documentation.  We silently generate
>   documentation like
> 
>       name-of-member
>           Not documented
> 
>   for them.
> 
>   Possible improvement: make missing member documentation a hard error,
>   create a knob to suppress the error for a type.  Open question: how to
>   best document member documentation is incomplete.

@MigrationSetParameters should fall into this category.

IMHO it's just wanted in some use case that we don't want to list member
documentations, instead we want to show something else. In this case
referring to documentation of another object (@MigrationParameters).

> 
> * Suppress documentation for internal-only definitions
> 
>   Problem: generated documentation covers everything, even types that
>   aren't visible in QMP.  The irrelevant material is distracting and
>   possibly confusing for users, and may be bothersome to maintain for
>   developers.
> 
>   Possible improvement: include only the types visible in QMP in
>   documentation, similar to how we do for query-qmp-schema.  Open
>   question: what level of documentation to require for internal-only
>   types.

@MigrationParameter should fall into this category.

IMHO we should treat them the same as any code written, for example, in C.
We don't necessarily need to apply any rule on it, like we don't require
comment for any line of code, but we prefer comments / documentations when
necessary.  That (how much documentation needed for the code) is judged
during code review, and can apply also to internally used QAPI definitions.

Thanks,

-- 
Peter Xu


