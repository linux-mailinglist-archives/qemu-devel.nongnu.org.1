Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB9763B0F
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgCz-0002io-8z; Wed, 26 Jul 2023 11:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOgBu-0001oq-19
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOgBq-0001Qz-3y
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690384356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otaj9+NNs+4VblJLKY/BA+qGfSTs5gimsln3r1kszTE=;
 b=ViChYD7ffqzO0yloQYjakTORh3HFQ2p5F6471AfjxOkAdVMIiTJBH1XjQQ7LX6f06mqC+g
 ZipSavn498kIr1U2G6uoCPwfVL10fq14LmxsyQAgEwfEL2EVnpNJKkwcU2dF6Z/k63m+SR
 T94C6IxEkKZSk6aKwCp5Nl0AFkb9JEs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-IJS39oWKNG6ABW6f0VHfgA-1; Wed, 26 Jul 2023 11:12:35 -0400
X-MC-Unique: IJS39oWKNG6ABW6f0VHfgA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-767a1ad2175so148370185a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690384355; x=1690989155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otaj9+NNs+4VblJLKY/BA+qGfSTs5gimsln3r1kszTE=;
 b=ewVAtJ2cXcJ39ppLk7skVv4DxbLyhmwsHXdwLGNpizXxlitQXeNLdRdgESTurwlvFJ
 IJGmHr7hgKnGDo6rMwAQDiprEqIdJOCVxxN4trrR1iD6CjiWk3r1+FrLoc/kwF2+Qrk4
 Kv+uJr8RCq0sTVlt9lY3z3TWQcTRtTbu2dTgPsRfCkvL+CJFQYGb9sc61KUimP66Jkce
 1TuEiMS8QvA/O8lZhoySL96GKvMwuvKyVCT5bH0jefTbGeMCzG5cUt1A7HUlfaugJJPg
 kFpyeFmQAE/b8O5/MvcFH4mKF48NHG6lOndl7JtIcqC1/pdMqlyXXbQV0vlerAI9L3rh
 R07A==
X-Gm-Message-State: ABy/qLbdL26sZveMlWIgajJOfCOwlFCqrRWK/PEtQe+4rTIom7U7f6+1
 tfv+z8IAoQ5E7y1f9DFJbilvv/atKPoVLF/kPkm+6MrqkC2jQgRXPlwbPx0IMBjR6QhDhAqNjEK
 g0lupCF+E0Vvwxc8=
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id
 h7-20020a05620a400700b00763a1d3196dmr3157999qko.0.1690384354667; 
 Wed, 26 Jul 2023 08:12:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHo77csef0ei2lq9nRq7ciGOAvOxobjg668e/2Fhksw80Ey3UHJNw4N+EkuRg8xI9VvWlLdBQ==
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id
 h7-20020a05620a400700b00763a1d3196dmr3157975qko.0.1690384354392; 
 Wed, 26 Jul 2023 08:12:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oq15-20020a05620a610f00b007676658e369sm4413662qkn.26.2023.07.26.08.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 08:12:34 -0700 (PDT)
Date: Wed, 26 Jul 2023 11:12:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZME33z8vFL0fRGYV@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7jz8a6o.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Hi, Markus,
> >
> > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
> 
> [...]
> 
> >> For better or worse, we duplicate full documentation between
> >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
> >> would be the first instance where we reference instead.  I'm not opposed
> >> to use references, but if we do, I want them used consistently.
> >
> > We discussed this over the other "switchover" parameter, but that patchset
> > just stranded..
> >
> > Perhaps I just provide a pre-requisite patch to remove all the comments in
> > MigrateSetParameters and MigrationParameters, letting them all point to
> > MigrationParameter?
> 
> Simplifies maintaining the doc commments.  But how does it affect the
> documentation generated from it?  Better, neutral, or worse?

Probably somewhere neutral.  There are definitely benefits, shorter
man/html page in total, and avoid accidentally different docs over the same
fields.  E.g., we sometimes have different wordings for different objects:

       max-cpu-throttle
              maximum cpu throttle percentage.  Defaults to 99.  (Since 3.1)

       max-cpu-throttle: int (optional)
              maximum cpu throttle percentage.  The default value is 99. (Since 3.1)

This one is fine, but it's just very easy to leak in something that shows
differently.  It's good to provide coherent documentation for the same
fields over all three objects.

When looking at qemu-qmp-ref.7, it can be like this when we can invite the
reader to read the other section (assuming we only keep MigrationParameter
to keep the documentations):

   MigrationParameters (Object)

       The object structure to represent a list of migration parameters.
       The optional members aren't actually optional.  For detailed
       explanation for each of the field, please refer to the documentation
       of MigrationParameter.

But the problem is we always will generate the Members entry, where now
it'll all filled up with "Not documented"..

   Members
       announce-initial: int (optional)
              Not documented

       announce-max: int (optional)
              Not documented

       announce-rounds: int (optional)
              Not documented

       [...]

I think maybe it's better we just list the members without showing "Not
documented" every time for the other two objects.  Not sure whether it's an
easy way to fix it, or is it a major issue.

For developers, dedup the comment should always be a win, afaict.

Thanks,

-- 
Peter Xu


