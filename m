Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C47C6452
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnqe-0007Mc-Jf; Thu, 12 Oct 2023 01:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqnqY-0007JL-4y
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqnqS-0005Mh-TR
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697086966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEpuwG2bay5KSJPJMED03m4/4dDBW5i8wGLKdx1G47s=;
 b=fBY70VRlg3KVHiL90CSQq+6GUelIZPgW1NCOQflSjN/O+DBkTL1R1YUBQE0Fss7CZpc762
 Tn83Qxzoj+u0JVqJOZPGdr1N4flRGdK5ngKaqFr102HnLBZI8vvb+xIdkiSc7nuvAW+dYw
 q9E1gdNUI3HdqqKnf8DMhCzLzRtuIBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-raQN4y-POpSPmemt03LyXw-1; Thu, 12 Oct 2023 01:02:40 -0400
X-MC-Unique: raQN4y-POpSPmemt03LyXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40886811E7B;
 Thu, 12 Oct 2023 05:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 193781C060AE;
 Thu, 12 Oct 2023 05:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BBB221E6904; Thu, 12 Oct 2023 07:02:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 peter.maydell@linaro.org,  alex.bennee@linaro.org,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  quic_tsoni@quicinc.com,  quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com,  quic_yvasi@quicinc.com,
 quic_cvanscha@quicinc.com,  quic_mnalajal@quicinc.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC/PATCH v0 01/12] hw/arm/virt: Avoid NULL pointer de-reference
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-2-quic_svaddagi@quicinc.com>
 <b98e4566-56b4-d0e4-adb2-c163c7c26cfb@linaro.org>
Date: Thu, 12 Oct 2023 07:02:39 +0200
In-Reply-To: <b98e4566-56b4-d0e4-adb2-c163c7c26cfb@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 12 Oct 2023 06:30:24
 +0200")
Message-ID: <875y3cph5c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Srivatsa,
>
> (+Markus/Peter for QOM fu)

QOM fu needs Paolo; cc'ed.

I'm not sure how much this is about QOM, though.  Perhaps it's more
about good taste.

> On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
>> Avoid dereferencing a NULL pointer that its_class_name() could return.
>
> While your patch is correct, there is some code smell
> around its_class_name(). IMHO a foo_class_name() handler
> should never return NULL.
>
> I'm trying to rework apic_get_class() similarly, see:
> https://lore.kernel.org/qemu-devel/20231003082728.83496-1-philmd@linaro.o=
rg/

In both cases, we have a function to find the device model to use with
current QEMU configuration and system state.  The fact that one of them
returns a class name and the other a class is detail.

Observe: this usable device model exists for any QEMU configuration.  It
may not be usable in certain system states, though.

Since the function deals with both, it can fail.

We can separate the two concerns: first map configuration to device
model (can't fail), then check the system state (can fail).

Feels like a matter of taste to me.  Does it result in simpler function
contracts and more readable code?  Can we do it the same way everywhere?


