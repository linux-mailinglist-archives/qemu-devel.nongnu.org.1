Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DA8032B9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 13:31:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA85O-00039m-CN; Mon, 04 Dec 2023 07:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rA85M-00039R-3a
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:30:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rA85J-0002Da-Ed
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:30:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A7DB1FE60;
 Mon,  4 Dec 2023 12:29:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3B461398A;
 Mon,  4 Dec 2023 12:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5ljWLUPGbWWSCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Dec 2023 12:29:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Liu, Yuan1" <yuan1.liu@intel.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v2 3/4] configure: add qpl option
In-Reply-To: <BY5PR11MB4388B24F2EF2D319325F4673A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-4-yuan1.liu@intel.com> <87cyvpbywv.fsf@suse.de>
 <BY5PR11MB4388B24F2EF2D319325F4673A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
Date: Mon, 04 Dec 2023 09:29:53 -0300
Message-ID: <87edg2gnge.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.81 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 NEURAL_HAM_LONG(-0.98)[-0.975]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 2.81
X-Rspamd-Queue-Id: 7A7DB1FE60
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

"Liu, Yuan1" <yuan1.liu@intel.com> writes:

>> -----Original Message-----
>> From: Fabiano Rosas <farosas@suse.de>
>> Sent: Saturday, December 2, 2023 1:45 AM
>> To: Liu, Yuan1 <yuan1.liu@intel.com>; quintela@redhat.com;
>> peterx@redhat.com; leobras@redhat.com
>> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
>> <nanhai.zou@intel.com>
>> Subject: Re: [PATCH v2 3/4] configure: add qpl option
>> 
>> Yuan Liu <yuan1.liu@intel.com> writes:
>> 
>> > the Query Processing Library (QPL) is an open-source library that
>> > supports data compression and decompression features.
>> >
>> > add --enable-qpl and --disable-qpl options to enable and disable the
>> > QPL compression accelerator. The QPL compression accelerator can
>> > accelerate the Zlib compression algorithm during the live migration.
>> >
>> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
>> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>> > ---
>> >  meson.build                   | 7 +++++++
>> >  meson_options.txt             | 2 ++
>> >  scripts/meson-buildoptions.sh | 3 +++
>> >  3 files changed, 12 insertions(+)
>> >
>> > diff --git a/meson.build b/meson.build index 259dc5f308..b4ba30b4fa
>> > 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -1032,6 +1032,11 @@ if not get_option('zstd').auto() or have_block
>> >                      required: get_option('zstd'),
>> >                      method: 'pkg-config')  endif
>> > +qpl = not_found
>> > +if not get_option('qpl').auto()
>> > +    qpl = dependency('libqpl', required: get_option('qpl'),
>> > +                     method: 'pkg-config') endif
>> 
>> Hm.. I'm not having success with pkg-config:
>> 
>> ../meson.build:1043:10: ERROR: Dependency "libqpl" not found, tried
>> pkgconfig
>> 
>> It seems it doesn't find the static library. I had to use this instead:
>> 
>> qpl = declare_dependency(dependencies: cc.find_library('qpl',
>>                          required: get_option('qpl')))
>> 
>> What am I missing here?
> Sorry about this, the QPL repo(https://github.com/intel/qpl) does not yet support libqpl pkg-config file, we are in the process of adding this functionality and we hope to resolve libqpl's dependencies through pkg-config file.
> I will explicitly address this issue and provide relevant documentation in the next version.

Ok, just remember to test with a clean setup next time.

>
> For the pkg-config test, 
> 1. create /usr/lib64/pkgconfig/libqpl.pc
> 2. add below lines
> prefix=/usr/local
> exec_prefix=${prefix}
> libdir=${exec_prefix}/lib
> includedir=${prefix}/include
>
> Name: libqpl
> Description: Intel Query Processing Library
> Version: 1.3.0
> Libs: -L${libdir} -lqpl -lpthread -laccel-config -ldl -lstdc++

We could probably do this with meson directly instead of requiring a
pkg-config preliminary setup. My meson-fu is not the best, but something
like:

  qpl = declare_dependency(dependencies: [
       cc.find_library('qpl', required: get_option('qpl')),
       cc.find_library('accel-config', required: get_option('qpl')),
       ...
       ], link_args: ['-lstdc++', ...])

> Cflags: -I${includedir}
>
> 3. Install the header files to /usr/local/include/qpl and static library to /usr/local/lib64/libqpl.a

For this part is ok to just point to the official docs.


