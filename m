Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E44AE7C40E7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJ2w-0004Sl-P6; Tue, 10 Oct 2023 16:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJ2r-0004RX-Jl
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJ2n-00088E-Vv
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696968567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWPxfU3L2lALSxKoxfP/EEzgMrzvak2r7ERWMsNFuM4=;
 b=U1vGSYpLBQJwSoqMeIsg3NCa2dH8dP0+7xv96408JRM/isrXiIpKrjGu/91a1myk3XSf0N
 4DIIt8bZYm59tZ0hu8V4liAwP4HR4a2sYgn3UkN1lamRVfHTfcWWwRZe462j1ojA4P4GlT
 IuqmgQRIy+YdsKMsRIIk2G3G1CKxToU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-nu6Po7WQP0Kd0w29drCCOg-1; Tue, 10 Oct 2023 16:09:26 -0400
X-MC-Unique: nu6Po7WQP0Kd0w29drCCOg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7742bd869e4so117139385a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 13:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696968565; x=1697573365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWPxfU3L2lALSxKoxfP/EEzgMrzvak2r7ERWMsNFuM4=;
 b=pr3yDM1XHh0C/VA5Y+GhR+75N5/7gjDnvW1HtawcV96+vHXeE1XHBqwO18i/B5uWXZ
 zWC8YGhR+PkuOUWLmMJarmwFxnHKdCQlc3+wE1xBUQ+Ke5D3g9XlTLfUU5ZlZGBZcNxi
 b3UmSBcmTxQhDbtnogl+gQ7laRafFn1xcXVhtxQUC2WuARVqs+Gln+qvzSsaX/6xq3uR
 sbJRWaBjlcVqiNCcXnmJ73WVRdOGOyWE7UUs2jvBrJj0JmckfsdgXry9wiB7qePrqyVA
 T8hAzogcL2pX5aX6ZMyXNFkpjuaXm0PBKPk581jTMYCUadNgLh0WFs1d96i9i/e+E7yh
 cHqg==
X-Gm-Message-State: AOJu0YzpcdI5uStJmWTmqcgdTgQVXmvYahXBg6APL4TsgQVqYvk/DRk/
 vMevaJZ2TnUytGn7gArOfVoMhgu+Otxp+gynm+Gk/RJ4lilumSRv/ICtVQ3YRgFLQnbwjSweeUH
 CnKX6xVt+Ftj6nFc=
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr21181485qkb.3.1696968565738; 
 Tue, 10 Oct 2023 13:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw5N2Qv32sFqDYECMuOzcN5hRBYNjsUsqZtLuAa+yq0sK46UeL2pEw4bMQcIamuyMxP2i5lw==
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr21181467qkb.3.1696968565410; 
 Tue, 10 Oct 2023 13:09:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g1-20020a05620a13c100b0076e1e2d6496sm4589828qkl.104.2023.10.10.13.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 13:09:25 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:09:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Message-ID: <ZSWvYgKcGXlucXx6@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r8ajngg.fsf@pond.sub.org>
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

Hi, Markus,

On Tue, Oct 10, 2023 at 09:18:23PM +0200, Markus Armbruster wrote:

[...]

> >> The point I was trying to make is this.  Before the patch, we reject
> >> attempts to set the property value to null.  Afterwards, we accept them,
> >> i.e. the patch loses "reject null property value".  If this loss is
> >> undesirable, we better replace it with suitable hand-written code.
> >
> > I don't even know how to set it to NULL before.. as it can only be accessed
> > via cmdline "-global" as mentioned above, which must be a string anyway.
> > So I assume this is not an issue.
> 
> Something like
> 
>     {"execute": "migrate-set-parameters",
>      "arguments": {"tls-authz": null}}
> 
> Hmm, crashes in migrate_params_apply(), which is a bug.  I'm getting
> more and more suspicious about user-facing migration code...

Did you apply patch 1 of this series?

https://lore.kernel.org/qemu-devel/20230905162335.235619-2-peterx@redhat.com/

QMP "migrate-set-parameters" does not go via migration_properties, so even
if we change handling of migration_properties, it shouldn't yet affect the
QMP interface of that.

> 
> If the migration object is accessible with qom-set, then that's another
> way to assign null values.

I see what you meant.  IMHO we just don't need to worry on breaking that as
I am not aware of anyone using that to set migration parameters, and I
think the whole idea of migration_properties is for debugging.  The only
legal way an user should set migration parameters should be via QMP, afaik.

> In my "QAPI string visitors crashes" memo, I demonstrated that the crash
> on funny property type predates your series.  You merely add another
> instance.  Moreover, crashing -global is less serious than a crashing
> monitor command, because only the latter can take down a running guest.
> Can't see why your series needs to wait for a fix of the crash bug.
> Makes sense?

What's your suggestion to move on with this series without a fix for that
crash bug?

I started this series with making tls_* all strings (rather than StrOrNull)
and that actually worked out, mostly.  We switched to StrOrNull just
because we think it's cleaner and 100% not breaking anyone (even though I
still don't think the other way will).  I don't see how I can proceed this
series without fixing this visitor issue but keep using StrOrNull.

Please don't worry on blocking my work: it won't anymore.  The thing I need is:

https://lore.kernel.org/qemu-devel/20230905193802.250440-1-peterx@redhat.com/

While this whole series is just paving way for it.  If I can't get
immediate results out of this series, I'll just go with the triplications,
leaving all the rest for later.

Thanks,

-- 
Peter Xu


