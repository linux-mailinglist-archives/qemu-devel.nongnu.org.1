Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9B7FAC13
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:53:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ibA-0003Fm-9e; Mon, 27 Nov 2023 15:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7ib5-0003Eq-GS
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7ib3-0008Ur-BS
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701118368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXqEAG0jSPL2wlopU7THZ4e1So8Ke4lIRFkkjHEzqjk=;
 b=Q9YRLKizYzI4/u7/leZwFaLbhsSEdnJubM3VRdOhmfEiWRGqiG5RLEHSylqteWOSLLEuqc
 cWhZkAWC3ntOd3taEVy7Oh2LvYwfyt2V1qqUBTrTb70Cb75bcAOIti2qSTj4+Xoc6FO62E
 Yr7Wh/R8S8GXkbasZPYlA1S1ZAOTHfc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-rSHoE6qLOrq-1tQ4LN4ymQ-1; Mon, 27 Nov 2023 15:52:46 -0500
X-MC-Unique: rSHoE6qLOrq-1tQ4LN4ymQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-58d5a587f4aso516129eaf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 12:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701118366; x=1701723166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXqEAG0jSPL2wlopU7THZ4e1So8Ke4lIRFkkjHEzqjk=;
 b=JEdWM6StTeXBSyc/k79m7Vh2IVI5XcBL/8E26ykQSlEPsSUGvLB4YIpxoV0RkxQ/L5
 dlymQDn3w9RnMNWrbu7jE3/Qo3DbHexKtBTTvPgqZfWFtPQp+g+LIc86Zw3rfdU1iFEX
 mFKdRfxwd2TvHt1O/Y39VpAsDBRR/N5fuA8S6V6VPjq+H/6DfFJnrMlVsgI/a4awhTy7
 VD3Qmbn181IS3OoiIpM3gOiH76OKzx+lDJSn2ihzD6dKB8En+vIGXWOsmhc3KfKLcorA
 xsmAFhHwq64/SM5HOSioYxh2CtflqRxmSOX8vXeTBDfJ4L0V/t/qXYTB/jy3fTNogPpn
 Z9lA==
X-Gm-Message-State: AOJu0Yx4k280SAouEkSr9VSL2lKDAWzkZk0we6L2NI+MPlwuhB42PQzP
 q2fe8AMcIuQiIkfluOBRvXqtHPhsUJ8mTBsotW+UxwUqD7paAIY+wVzVJU4fNnlysG4bXAQZqsb
 piM1i+IgyNi8tbxU=
X-Received: by 2002:a05:6358:c8f:b0:16e:2824:2f06 with SMTP id
 o15-20020a0563580c8f00b0016e28242f06mr10315655rwj.3.1701118365956; 
 Mon, 27 Nov 2023 12:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZJNu90Ux0Bpu5X4KoQhLpXvw82RnA/IMrhtMP6YBiZzA+zufXVjbXsjfGhQnW95WBce09pA==
X-Received: by 2002:a05:6358:c8f:b0:16e:2824:2f06 with SMTP id
 o15-20020a0563580c8f00b0016e28242f06mr10315643rwj.3.1701118365652; 
 Mon, 27 Nov 2023 12:52:45 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 i10-20020ac860ca000000b004199c98f87dsm4007479qtm.74.2023.11.27.12.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 12:52:45 -0800 (PST)
Date: Mon, 27 Nov 2023 15:52:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 5/7] tests/qtest/migration: Print migration incoming
 errors
Message-ID: <ZWUBliv9IpYOBLtz@x1n>
References: <ZWSswkonmoz2ryQu@x1n> <87ttp72ny1.fsf@suse.de>
 <ZWT6pCri-NmPy3Bt@x1n> <87r0kb2az6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0kb2az6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 27, 2023 at 05:32:45PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Nov 27, 2023 at 12:52:38PM -0300, Fabiano Rosas wrote:
> >> >> @@ -118,6 +118,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> >> >>  
> >> >>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> >> >>                      args);
> >> >> +
> >> >> +    if (!qdict_haskey(rsp, "return")) {
> >> >> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> >> >> +        g_test_message("%s", s->str);
> >> >> +    }
> >> >
> >> > This traps the "migrate-incoming" command only (which, afaiu, only setup
> >> > the listening), would this capture the incoming error?
> >> 
> >> This is about the migrate-incoming only. We could replace "incoming
> >> migration" with "qmp_migrate_incoming" in the commit message to clarify.
> >
> > Ah.. Did you ever see this failure in any of your runs in these tests?  I
> > think it means you hit the assertion right below this part, but I'm just
> > curious how, as the URIs in the test cases are pretty constant.
> 
> Yes, I don't remember what exactly, but we changed the code that parses
> the URIs in this release and I'm also working on
> file_start_incoming_migration.

OK then.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


