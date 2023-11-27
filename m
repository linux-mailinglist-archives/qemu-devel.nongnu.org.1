Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C177FA566
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:57:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dyN-0007f6-EP; Mon, 27 Nov 2023 10:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7dyL-0007dg-07
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7dyJ-0008Vk-KP
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701100590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEnvog/Q8aPfUl/eYFBChdiW9uxnBxBrEVVDkrY1D/8=;
 b=cokr+/czZwgmNcOqGPJ6w1bo9tsHqgoyJ/9Ed3IH4B+RUqyVDtdOqEx+f5taDsiqcNKz0U
 9Mowvx4e0Cstp0yUcOwTmq6Q1gFm0ihDEE3DVXM2AFhTO+WFLJHlshppyIS9/N7zgmgIC2
 gGSn1LLmbVM5dErrOcCk6rKkmoaKeew=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-RT34Q3waMb29W6MLRUAGSw-1; Mon, 27 Nov 2023 10:56:29 -0500
X-MC-Unique: RT34Q3waMb29W6MLRUAGSw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d683d5775so110665385a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 07:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701100588; x=1701705388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEnvog/Q8aPfUl/eYFBChdiW9uxnBxBrEVVDkrY1D/8=;
 b=SlPxkdTtXwTTIxRFigLaRjhRwPDWGWN1jZnSTdiFHxNdctML7DMdM5VrtgNYQviY/M
 0y8q5GaQXWNnG910DiArRUa/bxfEbeoxb3/1P/2Xr7xSpMbi7fZaOAUVEyFjBBy6IA3h
 3jqa5bpPt+7W9Gw6KKhHSkVsvAP9de8onc4T8aLsm9GkntHp053MGyFnHIt+q+TPS/UX
 TN7O3+iAl9HmO7uANOQMbjmbOqc/uB0Jtovf8/dJ+bin2Qsxh3D3PdTbRMF6GqPR/ODC
 QVfVKu/zrFZvJoWY4jgMpn2XnqnlrghIJe3cvBsa7I2NEQ4Jnz5EpSVeivOE3MhAHVFf
 Grhg==
X-Gm-Message-State: AOJu0YwdtaoXD5WHMSnntZI4qI9VuXAmdyTPsxQbVF7Lm5jBRiNMXUfK
 mUylwN17wG8fX16AFBuLeccibcDitBnRGiuPS+1VU/lgG5DuqBpMqsz7gv0idMAc/7ZQa0Xxp2k
 t332D1K5H1laOB1M=
X-Received: by 2002:a05:620a:4710:b0:77d:59c7:8eb9 with SMTP id
 bs16-20020a05620a471000b0077d59c78eb9mr14203253qkb.7.1701100588563; 
 Mon, 27 Nov 2023 07:56:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsFMtwCmNQln+DXFeLdAb4AgfN9kwoKAbax6rZ6soDU1ZcUf1XLbK0ACd1MW6iW+wiS0c7vg==
X-Received: by 2002:a05:620a:4710:b0:77d:59c7:8eb9 with SMTP id
 bs16-20020a05620a471000b0077d59c78eb9mr14203247qkb.7.1701100588312; 
 Mon, 27 Nov 2023 07:56:28 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 dv16-20020a05620a1b9000b0077d85d22e89sm2645573qkb.63.2023.11.27.07.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 07:56:28 -0800 (PST)
Date: Mon, 27 Nov 2023 10:56:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 6/7] tests/qtest/migration: Add a wrapper to print
 test names
Message-ID: <ZWS8KguxGJi9idtQ@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-7-farosas@suse.de> <ZWStsHj23pCbuGPP@x1n>
 <87y1ej2oay.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1ej2oay.fsf@suse.de>
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

On Mon, Nov 27, 2023 at 12:44:53PM -0300, Fabiano Rosas wrote:
> >> +static void migration_test_wrapper(const void *data)
> >> +{
> >> +    MigrationTest *test = (MigrationTest *)data;
> >> +
> >> +    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
> >
> > /%s/%s?
> 
> The test name contains a leading slash.

Then I suppose qtest_add_func() just tried to omit the duplicated '/'?

Never mind then.  My R-b holds.  Thanks,

-- 
Peter Xu


