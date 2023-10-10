Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325867BF9E6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqB36-0007Ij-OD; Tue, 10 Oct 2023 07:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqB2b-0006mq-ME
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqB2W-0003Rz-Q3
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696937798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=0B66+I6h0TS2fpK0YANwT4mEMv1IXjmYyrDuaMBRl0M=;
 b=eaG5O4xpRZl1iAxaOJ7CCnPhkmayDLyrwnyYbrCP2ORScyy/mAgwHoPvhDGDPewAIFl4Rz
 lQukb08NhyUaWmr5GMJjAh+FoiRVhhwucsFSwCndm8hHBDWGQtr23PbSoTYJnYezTn5DFy
 2dLChTSvfAd2UpQ+VsMTJYK+4+h8MOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-df81rboGOu6hxIUmUW1d2w-1; Tue, 10 Oct 2023 07:36:35 -0400
X-MC-Unique: df81rboGOu6hxIUmUW1d2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6C7A81B13F;
 Tue, 10 Oct 2023 11:36:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 755341B9C;
 Tue, 10 Oct 2023 11:36:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E84621E6904; Tue, 10 Oct 2023 13:36:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>
Subject: QAPI string visitors crashes
Date: Tue, 10 Oct 2023 13:36:33 +0200
Message-ID: <875y3epv3y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu recently made me aware of a crash bug that turned out to be
caused by disobeying string input visitor restrictions:

    /*
     * The string input visitor does not implement support for visiting
     * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
     * of integers (except type "size") are supported.
     */

The string input visitor has few uses outside tests/.  Let's review
them:

* object_property_parse()

  Set a QOM property to a value parsed from a string.  Uses:

  - hmp_qom_set()

    This is HMP command qom-set without -j.  Positional arguments are
    QOM path, property name and value.  Can target arbitrary QOM
    property, and therefore visit an arbitrary QAPI type.  Crashes when
    the type is one the string input visitor doesn't implement.
    Reproducer: "qom-set /machine memory junk".

    We created this bug when we added QOM properties with "funny" types
    without fully considering the implications.

  - object_apply_global_props()

    Called for each -global DRIVER.PROPERTY=VALUE and for each "compat
    prop".

    -global can target arbitrary qdev property.  Same crash risk, but I
    can't see one with a visitor-crashing type offhand.  Peter's "[PATCH
    v3 0/4] qapi/migration: Dedup migration parameter objects and fix
    tls-authz crash" adds some, e.g. "-global migration.tls-authz=junk".

    "Compat props" are purely internal.  Looks safe.

  - object_set_propv()

    Convenience interface for setting properties from C code.  Usable
    only with properties whose type the string input visitor can handle.
    I can see maybe half a dozen uses that aren't just for testing.  The
    property names are all literals.  Looks safe.

  - pc_machine_init_sgx_epc()

    Set QOM object "sgx-epc" link property "memdev" to the value of QAPI
    type SgxEPC member @memdev.  Visits a QAPI string, which is safe.

  - x86_cpu_apply_props()

    Set default CPU properties from kvm_default_props[] or
    tcg_default_props[].  Looks like these are all of boolean type,
    which is safe.

  - x86_cpu_apply_version_props()

    Set version-specific CPU properties from X86CPUDefinition member
    @versions member @props.  Looks like these are all of scalar type
    which are safe.

* hmp_migrate_set_parameter()

  This is HMP command migrate_set_parameter.  Positional arguments are
  the parameter name and value.  QAPI types are all scalar so far, which
  are safe.

Ways to fix the crash bug:

1. Lift the string input visitor restrictions

   Requires new syntax for the missing QAPI types.  I don't think
   inventing more syntax is a good idea.  We already have human-friendly
   syntax for most of the missing types: keyval_parse(), used with the
   QObject input visitor.  Comes with restrictions (see keyval.c), but
   no crashes.  We commonly use it in a way that also accepts JSON,
   unrestricted: qobject_input_visitor_new_str().

2. Fail instead of crash

   Still have to use qom-set -j for certain properties.  Fine.

   Can't use -global for certain properties.  Not so fine.  Could create
   alternative syntax that always works, like we did for qom-set.

   The two ways to do human-friendly input (string input visitor
   vs. keyval_parse() + QObject input visitor) both come with restrictions
   that may necessitate use of JSON (fine), but when exactly that's
   needed differs (not fine).

   Meh.

3. Unified solution for QAPI-based human-friendly input

   keyval_parse() + QObject input visitor works for complex QAPI types
   only.  To replace the string input visitor, we need something that
   also works for the QAPI types the string input visitor can do now:
   scalars and array of integers.

   The restriction to complex QAPI types is in keyval_parse(): it parses
   into a QDict.

   I believe we can create a variant of keyval_parse() that parses into
   a QObject instead.

   Side note: keyval_parse()'s restriction to complex QAPI types enables
   easy JSON support: qobject_input_visitor_new_str() assumes JSON when
   the string starts with '{'.  An unrestricted variant couldn't do
   that, at least not easily.  There's a reason qom-set requires a -j
   flag instead of recognizing JSON automatically.

   Affected stable external interfaces: as far as I can tell just
   -global.  QMP qom-set is not affected, since it uses the QObject
   input visitor, not the string input visitor.

   I think we should offer a JSON-based alternative t0 -global, both for
   full generality (which our human-readable syntax cannot provide), and
   because management applications are better off with JSON.

Thoughts?


