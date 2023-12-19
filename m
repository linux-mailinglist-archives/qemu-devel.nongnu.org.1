Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1CB818283
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:45:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFUlT-0005PS-9u; Tue, 19 Dec 2023 02:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFUlR-0005P5-VD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFUlP-0008Mm-Pt
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702971817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1BQ3vPTm/FhEek/HD2X3vWKjVSt5DMIxRYkMxJUkbjg=;
 b=SbAMZo69wyRV7o+HiWTl9Ty0o18pHSO2CXjGxylJxP3sq5KmReF8xZIZa+pzR3th3Q6GaO
 tAQtvx1uVvPVw1TskbbCAfQijJ+PCP+OGmvtK8oMcgcUJ0waZAhJMwoRjUj7pu5OcipQ3p
 ZMtXng5vwVtHQC7QxZ/JP2h+vyUYd4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-3gfWJVJFM2OuV5WgpkP9NQ-1; Tue, 19 Dec 2023 02:43:35 -0500
X-MC-Unique: 3gfWJVJFM2OuV5WgpkP9NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9D2F85A59D;
 Tue, 19 Dec 2023 07:43:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84D981121306;
 Tue, 19 Dec 2023 07:43:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C81621E6920; Tue, 19 Dec 2023 08:43:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,  Michal Privoznik
 <mprivozn@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  qemu-block@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 aliang@redhat.com,  qinwang@redhat.com
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
In-Reply-To: <20231211211502.GA431872@fedora> (Stefan Hajnoczi's message of
 "Mon, 11 Dec 2023 16:15:02 -0500")
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <ZXcVCMU7hYZ6jhp3@redhat.com> <87msugah6x.fsf@pond.sub.org>
 <20231211211502.GA431872@fedora>
Date: Tue, 19 Dec 2023 08:43:33 +0100
Message-ID: <87zfy6myca.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Dec 11, 2023 at 04:32:06PM +0100, Markus Armbruster wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
>> >> virtio-blk and virtio-scsi devices will need a way to specify the
>> >> mapping between IOThreads and virtqueues. At the moment all virtqueues
>> >> are assigned to a single IOThread or the main loop. This single thread
>> >> can be a CPU bottleneck, so it is necessary to allow finer-grained
>> >> assignment to spread the load.
>> >> 
>> >> Introduce DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST() so devices can take a
>> >> parameter that maps virtqueues to IOThreads. The command-line syntax for
>> >> this new property is as follows:
>> >> 
>> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]}'
>> >> 
>> >> IOThreads are specified by name and virtqueues are specified by 0-based
>> >> index.
>> >> 
>> >> It will be common to simply assign virtqueues round-robin across a set
>> >> of IOThreads. A convenient syntax that does not require specifying
>> >> individual virtqueue indices is available:
>> >> 
>> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]}'
>> >> 
>> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >
>> > When testing this, Qing Wang noticed that "info qtree" crashes. This is
>> > because the string output visitor doesn't support structs. I suppose
>> > IOThreadVirtQueueMapping is the first struct type that is used in a qdev
>> > property type.
>> >
>> > So we'll probably have to add some kind of struct support to the string
>> > output visitor before we can apply this. Even if it's as stupid as just
>> > printing "<struct IOThreadVirtQueueMapping>" without actually displaying
>> > the value.
>> 
>> The string visitors have been nothing but trouble.
>> 
>> For input, we can now use keyval_parse() and the QObject input visitor
>> instead.  Comes with restrictions, but I'd argue it's a more solid base
>> than the string input visitor.
>> 
>> Perhaps we can do something similar for output: create a suitable
>> formatter for use it with the QObject output visitor, replacing the
>> string output visitor.
>
> I sent an initial patch that just shows "<omitted>" but would like to
> work on a proper solution with your input.
>
> From what I've seen StringOutputVisitor is used in several places in
> QEMU. "info qtree" calls it through object_property_print() to print
> individual qdev properties. I don't understand the requirements of the
> other callers, but object_property_print() wants to return a single
> string without newlines.

string_output_visitor_new():

* hmp_info_migrate(): format a list of integers, then print it like

        monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);

  One element per vCPU; can produce a long line.

* netfilter_print_info(): format the property values of a
  NetFilterState, then print each like

        monitor_printf(mon, ",%s=%s", prop->name, str);

* object_property_print(): format a property value of an object, return
  the string.

  Function is misnamed.  object_property_format() or
  object_property_to_string() would be better.

  Just one caller: qdev_print_props(), helper for hmp_info_qtree().
  Prints the string like

        qdev_printf("%s = %s\n", props->name,
                    *value ? value : "<null>");

  where qdev_printf() is a macro wrapping monitor_printf().

  This one passes human=true, unlike the others.  More on that below.

* hmp_info_memdev(): format a list of integers, then print it like

        monitor_printf(mon, "  policy: %s\n",
                       HostMemPolicy_str(m->value->policy));

  One element per "host node", whatever that may be; might produce a
  long line.

* Tests; not relevant here.

hmp_info_migrate() and hmp_info_memdev() use the visitor as a (somewhat
cumbersome) helper for printing uint32List and uint16List, respectively.
Could do without.

The other two display all properties in HMP.  Both kind of assume the
string visitor produces no newlines.  I think we could instead use the
QObject output visitor, then format the QObject in human-readable form.
Might be less efficient, because we create a temporary QObject.  Perhaps
factor out a single helper first.

string_input_visitor_new(), for good measure:

* hmp_migrate_set_parameter(): parse an uint8_t, uint32, size_t, bool,
  str, or QAPI enum from a string.

* object_property_parse(): parse a property value from a string, and
  assign it to the property.

  Calling this object_property_set_from_string() would be better.

  Callers:

  - object_apply_global_props(): applying compatibility properties
    (defined in C) and defauls set with -global (given by user).

  - object_set_propv(): helper for convenience functions to set multiple
    properties in C.

  - hmp_qom_set(): set the property value when not JSON (-j is off).

  - object_parse_property_opt(), for accelerator_set_property(), which
    processes the argument of -accel.

  - x86_cpu_apply_props() and x86_cpu_apply_version_props(): apply
    properties defined in C.

  The property settings defined in C could just as well use QObject
  input visitor instead.  Might be less efficient, because we create a
  temporary QObject.

  The property settings that come from the user are ABI.

  Reminder: supports only scalars and lists of small integers.
  Supporting structured values containing strings would involve creating
  syntax that's basically reinventing JSON.

  I think qom-set demonstrates how to support structured values: just
  use JSON.

> QObjectOutputVisitor produces a QObject. That could be formatted as
> JSON using qobject_to_json_pretty()?
>
> The pretty JSON would contain newlines and existing callers such as
> "info qtree" may need to scan the output and insert indentation.

With pretty=false, the JSON formatter produces a string without
newlines.  With pretty=true, it adds newlines and indentation.

Instead of scanning the formatted string to change its indentation, we
could perhaps pass indentation instructions to the JSON formatter.

> The goal would be to keep the output unchanged as far as possible and to
> emit JSON for structs and lists.

That's basically JSON, except we print 'str' values without quotes and
escapes (resulting in ambiguity when they contain {[]}, and even more
fun when they contain control characters), plus a few more largely
gratuitous differences.

With human=true (advertized as "a bit easier for humans to read"), we
get strings with quotes (still no escapes), and a tweaked set of
gratuitous differences.

> What do you think about this approach?

Format as JSON and call it a day?

I figure the only thing of value we'd lose is displaying integers both
decimal and hex.  In some, but not all places.


