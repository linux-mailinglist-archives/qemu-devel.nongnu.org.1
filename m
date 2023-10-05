Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 017917B9B03
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHS0-0004ue-Q4; Thu, 05 Oct 2023 02:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoHRz-0004tq-62
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoHRw-0004MN-NZ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696485783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfVTMD+29yEdGNgceUILxhddZr5fLFXs3J4fyYNQK/4=;
 b=TfA78cd5j/ImZ9aaop8RE9mRE/z/h0vmX9OxSr6lFJCs1ZW3fUOqS5sagCx1+kzRfAJxgj
 AO645x/QEXu5ZzpqgwwkuibdtJGW5uPy7VK8Rx1/VSEkd4xXb41zSmmjN6BmUCvzRdJBlm
 JurqOK2H8+nxoZBVqwRby8tetqxWSgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-HJdftPpFNQSIS-HwBRkDDw-1; Thu, 05 Oct 2023 02:02:37 -0400
X-MC-Unique: HJdftPpFNQSIS-HwBRkDDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 451D3800045;
 Thu,  5 Oct 2023 06:02:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD8ADC15BB8;
 Thu,  5 Oct 2023 06:02:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A99021E6904; Thu,  5 Oct 2023 08:02:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>,  "stefanha@redhat.com" <stefanha@redhat.com>,
 "ale@rev.ng" <ale@rev.ng>,  "anjo@rev.ng" <anjo@rev.ng>,  "Marco Liebel
 (QUIC)" <quic_mliebel@quicinc.com>,  "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>
Subject: Re: [PULL 0/2] hex queue
References: <20231004004806.1461248-1-bcain@quicinc.com>
 <87mswyltwl.fsf@pond.sub.org>
 <SN6PR02MB4205C95307F85E2DA102EB24B8CBA@SN6PR02MB4205.namprd02.prod.outlook.com>
Date: Thu, 05 Oct 2023 08:02:35 +0200
In-Reply-To: <SN6PR02MB4205C95307F85E2DA102EB24B8CBA@SN6PR02MB4205.namprd02.prod.outlook.com>
 (Brian Cain's message of "Wed, 4 Oct 2023 12:41:46 +0000")
Message-ID: <875y3la9ok.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Brian Cain <bcain@quicinc.com> writes:

>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Wednesday, October 4, 2023 2:38 AM
>> To: Brian Cain <bcain@quicinc.com>
>> Cc: qemu-devel@nongnu.org; richard.henderson@linaro.org;
>> philmd@linaro.org; peter.maydell@linaro.org; Matheus Bernardino (QUIC)
>> <quic_mathbern@quicinc.com>; stefanha@redhat.com; ale@rev.ng;
>> anjo@rev.ng; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>;
>> ltaylorsimpson@gmail.com
>> Subject: Re: [PULL 0/2] hex queue
>> 
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>> 
>> Looks like these patches haven't been posted to the list for (public)
>> review.  Needs to happen before a pull request.
>
> I'm sorry -- that was careless.  Matheus' patch had been but mine had not.
>
> I've sent Matheus and my patches to the list for review only just now.

Thanks!


