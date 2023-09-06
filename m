Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A09793C85
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrXe-000224-GF; Wed, 06 Sep 2023 08:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdrXC-0001vo-Bb
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdrX2-0002As-3V
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694002875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CytsB6juh8g7Xr22j5hRl41ph4dCRv1SBoXaY1riwk=;
 b=Hw81v+nz3eSFDqCrfbpZ8XcvXk0DYbrk6th2AY3kT0fS9dFL2GloZLJx5HbO0rk7lQ2TZp
 mW1xskKNZXs576JgWJ83bBy2KSXYFLH237qaTL6yRKv1CWjIAjTWlsLDKAsD9crUCjLlcc
 BrF1Nwah+6QMQmNiUvZJje4kqy91Hlw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-BfC1JyuGNHeO_6arSV-HyQ-1; Wed, 06 Sep 2023 08:21:10 -0400
X-MC-Unique: BfC1JyuGNHeO_6arSV-HyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D791D1052171;
 Wed,  6 Sep 2023 12:21:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F0340C2070;
 Wed,  6 Sep 2023 12:21:05 +0000 (UTC)
Date: Wed, 6 Sep 2023 13:21:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: William Tsai <williamtsai1111@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, Fam Zheng <fam@euphon.net>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2] qdict: Preserve order for iterating qdict elements
Message-ID: <ZPhurxruVwgfh46h@redhat.com>
References: <20230902094041.8626-1-williamtsai1111@gmail.com>
 <ZPYIBVtUgDGhj3TQ@redhat.com>
 <c9ab7061-22da-fed5-97bf-4924fe07cbf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9ab7061-22da-fed5-97bf-4924fe07cbf8@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 06, 2023 at 12:25:30PM +0200, David Hildenbrand wrote:
> On 04.09.23 18:38, Daniel P. Berrangé wrote:
> > On Sat, Sep 02, 2023 at 05:40:40PM +0800, William Tsai wrote:
> > > Changing the structure of qdict so that it can preserve order when
> > > iterating qdict. This will fix array_properties as it relies on `len-`
> > > prefixed argument to be set first.
> > > 
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
> > > Signed-off-by: William Tsai <williamtsai1111@gmail.com>
> > 
> > This is a variation of what Markus illustrated a year ago
> > 
> >    https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00758.html
> > 
> > I wasn't a particular fan of that approach at the time.
> > 
> > I've made an alternative proposal here which avoids the broader
> > impact of this QDict change:
> > 
> >    https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00652.html
> 
> Just a note regarding s390x CPU models (and how they are also affected, but
> it probably doesn't matter because it never 100% worked that way on all interfaces).

Oh, that's interesting to see a ordering scenario that isn't related
to the PROP_ARRAY stuff we already identified.

> I recall that I thought the order of parameters worked for s390x CPU models,
> where we support feature groups (due to the huge number of CPU features). But this
> might only have worked for the "-cpu" parameter, which parses them in-order and
> sets properties in-order.
> 
> So when mixing a feature group with contained features, the end result might not
> be deterministic in other cases thatn "-pu" (CPU hotplug via "-device", but
> also qapi CPU model operations).
> 
> For example, one might want to enable all but some features of a group, or
> disable all but some features of a group. Note that I doubt that there are really
> users of that, but it's possible on the QEMU cmdline.
> 
> I guess it never really worked with qapi CPU model operations in general
> (baseline, comparison, expansion, ...) because these
> operations all rely on qdict as well (see cpu_model_from_info()). So they should
> never return something non-deterministic.
> 
> 
> To highlight one case that could now fail:
> 
> $ ./qemu-system-s390x -smp 1,maxcpus=2 -cpu qemu,msa2=off,kimd-sha-512=on -nographic -nodefaults -monitor stdio -S -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on
> QEMU 8.1.50 monitor - type 'help' for more information
> qemu-system-s390x: warning: 'msa5-base' requires 'klmd-sha-512'.
> qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: warning: 'msa5-base' requires 'kimd-sha-512'.
> qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: warning: 'msa5-base' requires 'klmd-sha-512'.
> qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: Mixed CPU models are not supported on s390x.
> 
> Note that using "-device qemu-s390x-cpu,core-id=1" instead works as expected, as
> cpu_common_parse_features() registers all settings as global properties for
> that CPU type.
> 
> 
> Further, feature groups might not be used by actual users that way. CPU model expansion (s390_feat_bitmap_to_ascii()) only reports a feature group when all
> features are contained, so most of libvirt should be fine, unless someone decides to
> manually specify a non-deterministic CPU model as above.
> 
> So maybe one can conclude that specifying "msa2=off,kimd-sha-512=on" is similar to
> "kimd-sha-512=off,kimd-sha-512=on", and which setting "wins" is not deterministic.

Right now you can have arbitrary ordering of CPU feature groups and
individual features, with both on/off. Historically you could even have
the same feature name repeated with different on/off values and the last
occurrance would "win". This is incredibly flexible, but I think we could
argue this level of flexibility is overkill in practice for 99% of QEMU
deployments.

If we were to define two semantic rules for CPU specification:

  * All feature groups are processed before individiual features
  * A given feature group name or individual feature name may
    only appear once.

That would allow you to provide an implementation whose semantics
are not sensitive to the ordering of parameters, while still keeping
sufficient flexibility for all typical real world use cases.

The only thing I see lacking here is that it prevents users from doing
a "quick hack" of blindly appending  "foo=off" to an existing -cpu
argument - they would have to first check if 'foo' already appeared
in the existing -cpu arg and modify it in place. IMHO that's an
acceptable loss

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


