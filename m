Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE937DECFA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 07:49:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyRUG-0003j4-HY; Thu, 02 Nov 2023 02:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRUD-0003is-UM
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRUC-0008Gs-2p
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698907641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nucy7gxmH41/FHqntnLqAHDiWR5JRODW5yWghjMQdw0=;
 b=f1d/fHLbqt+b3DvZkSFB0oSeENDE44UfJ8NA5CX9eHpWJMSD7dvTqoYewpLD+HAYaRo0pA
 ui0AOwqfpoVqAL7FxfEvk2HQz3ZVW+47UjQgKaGAWG7qyhLL8y3eP9EuytCVDqpm3SVQzm
 1zHLm3g9fZGjASnhUQ6aMeaka5SGDC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-1ZPNLuTLOtWNrQGZml7XVw-1; Thu,
 02 Nov 2023 02:47:17 -0400
X-MC-Unique: 1ZPNLuTLOtWNrQGZml7XVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9D203822E8A;
 Thu,  2 Nov 2023 06:47:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 105D424C6;
 Thu,  2 Nov 2023 06:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03F1121E6A1F; Thu,  2 Nov 2023 07:47:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Ben
 Widawsky <bwidawsk@kernel.org>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Gregory Price
 <gourry.memverge@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 "Mike Maslenkin" <mike.maslenkin@gmail.com>,  Dave Jiang
 <dave.jiang@intel.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
 <87cyx04qcw.fsf@pond.sub.org> <20231031175522.00006073@Huawei.com>
Date: Thu, 02 Nov 2023 07:47:14 +0100
In-Reply-To: <20231031175522.00006073@Huawei.com> (Jonathan Cameron's message
 of "Tue, 31 Oct 2023 17:55:22 +0000")
Message-ID: <87wmv0d53h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 27 Oct 2023 06:54:39 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I'm trying to fill in QMP documentation holes, and found one in commit
>> 415442a1b4a (this patch).  Details inline.
>> 
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> 
>> > CXL uses PCI AER Internal errors to signal to the host that an error has
>> > occurred. The host can then read more detailed status from the CXL RAS
>> > capability.
>> >
>> > For uncorrectable errors: support multiple injection in one operation
>> > as this is needed to reliably test multiple header logging support in an
>> > OS. The equivalent feature doesn't exist for correctable errors, so only
>> > one error need be injected at a time.
>> >
>> > Note:
>> >  - Header content needs to be manually specified in a fashion that
>> >    matches the specification for what can be in the header for each
>> >    error type.
>> >
>> > Injection via QMP:
>> > { "execute": "qmp_capabilities" }
>> > ...
>> > { "execute": "cxl-inject-uncorrectable-errors",
>> >   "arguments": {
>> >     "path": "/machine/peripheral/cxl-pmem0",
>> >     "errors": [
>> >         {
>> >             "type": "cache-address-parity",
>> >             "header": [ 3, 4]
>> >         },
>> >         {
>> >             "type": "cache-data-parity",
>> >             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>> >         },
>> >         {
>> >             "type": "internal",
>> >             "header": [ 1, 2, 4]
>> >         }
>> >         ]
>> >   }}
>> > ...
>> > { "execute": "cxl-inject-correctable-error",
>> >     "arguments": {
>> >         "path": "/machine/peripheral/cxl-pmem0",
>> >         "type": "physical"
>> >     } }
>> >
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>> 
>> [...]
>> 
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > new file mode 100644
>> > index 0000000000..ac7e167fa2
>> > --- /dev/null
>> > +++ b/qapi/cxl.json
>> > @@ -0,0 +1,118 @@
>> > +# -*- Mode: Python -*-
>> > +# vim: filetype=python
>> > +
>> > +##
>> > +# = CXL devices
>> > +##
>> > +
>> > +##
>> > +# @CxlUncorErrorType:
>> > +#
>> > +# Type of uncorrectable CXL error to inject. These errors are reported via
>> > +# an AER uncorrectable internal error with additional information logged at
>> > +# the CXL device.
>> > +#
>> > +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
>> > +# @cache-address-parity: Address parity or other errors associated with the
>> > +#                        address field on CXL.cache
>> > +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
>> > +# @cache-data-ecc: ECC error on CXL.cache
>> > +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
>> > +# @mem-address-parity: Address parity or other errors associated with the
>> > +#                      address field on CXL.mem
>> > +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
>> > +# @mem-data-ecc: Data ECC error on CXL.mem.
>> > +# @reinit-threshold: REINIT threshold hit.
>> > +# @rsvd-encoding: Received unrecognized encoding.
>> > +# @poison-received: Received poison from the peer.
>> > +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
>> > +# @internal: Component specific error
>> > +# @cxl-ide-tx: Integrity and data encryption tx error.
>> > +# @cxl-ide-rx: Integrity and data encryption rx error.
>> > +##
>> > +
>> > +{ 'enum': 'CxlUncorErrorType',
>> > +  'data': ['cache-data-parity',
>> > +           'cache-address-parity',
>> > +           'cache-be-parity',
>> > +           'cache-data-ecc',
>> > +           'mem-data-parity',
>> > +           'mem-address-parity',
>> > +           'mem-be-parity',
>> > +           'mem-data-ecc',
>> > +           'reinit-threshold',
>> > +           'rsvd-encoding',
>> > +           'poison-received',
>> > +           'receiver-overflow',
>> > +           'internal',
>> > +           'cxl-ide-tx',
>> > +           'cxl-ide-rx'
>> > +           ]
>> > + }
>> > +
>> > +##
>> > +# @CXLUncorErrorRecord:
>> > +#
>> > +# Record of a single error including header log.
>> > +#
>> > +# @type: Type of error
>> > +# @header: 16 DWORD of header.
>> > +##
>> > +{ 'struct': 'CXLUncorErrorRecord',
>> > +  'data': {
>> > +      'type': 'CxlUncorErrorType',
>> > +      'header': [ 'uint32' ]
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @cxl-inject-uncorrectable-errors:
>> > +#
>> > +# Command to allow injection of multiple errors in one go. This allows testing
>> > +# of multiple header log handling in the OS.
>> > +#
>> > +# @path: CXL Type 3 device canonical QOM path
>> > +# @errors: Errors to inject
>> > +##
>> > +{ 'command': 'cxl-inject-uncorrectable-errors',
>> > +  'data': { 'path': 'str',
>> > +             'errors': [ 'CXLUncorErrorRecord' ] }}
>> > +
>> > +##
>> > +# @CxlCorErrorType:
>> > +#
>> > +# Type of CXL correctable error to inject
>> > +#
>> > +# @cache-data-ecc: Data ECC error on CXL.cache
>> > +# @mem-data-ecc: Data ECC error on CXL.mem  
>> 
>> Missing:
>> 
>>    # @retry-threshold: ...
>> 
>> I need suitable description text.  Can you help me?
>
> Spec says:
> "Retry Threshold Hit. (NUM_RETRY>=MAX_NUM_RETRY).
> See Section 4.2.8.5.1 for the definitions of NUM_RETRY and MAX_NUM_RETRY."
>
> Following the reference:
> "NUM_RETRY: This counter is used to count the number of RETRY.Req requests
> sent to retry the same flit. The counter remains enabled during the whole retry
> sequence (state is not RETRY_LOCAL_NORMAL). It is reset to 0 at initialization. It is
> also reset to 0 when a RETRY.Ack sequence is received with the Empty bit set or
> whenever the LRSM state is RETRY_LOCAL_NORMAL and an error-free retryable flit
> is received. The counter is incremented whenever the LRSM state changes from
> RETRY_LLRREQ to RETRY_LOCAL_IDLE. If the counter reaches a threshold (called
> MAX_NUM_RETRY), then the local retry state machine transitions to the
> RETRY_PHY_REINIT. The NUM_RETRY counter is also reset when the Physical layer
> exits from LTSSM recovery state (the LRSM transition through RETRY_PHY_REINIT
> to RETRY_LLRREQ)."
>
> So based on my failure to understand much of that beyond it has something
> to do with low level retries, maybe just
>
> "Number of times the retry threshold was hit."

Sold!  Thanks for your help.

> Thanks for tidying this up!

You're welcome!

I intend post the patch as part of a series filling in documentation
holes all over the place.  Will take some time, I'm afraid.

[...]


