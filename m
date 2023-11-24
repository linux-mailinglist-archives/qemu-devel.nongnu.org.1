Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12077F6F8C
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 10:28:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6STf-0003Xy-KV; Fri, 24 Nov 2023 04:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6STd-0003W3-Ib
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 04:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6STc-0008KL-0D
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 04:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700818074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHe6APctkLt0R9Ty4iBGvLnpq2axVP2/KRFfGx5vSrA=;
 b=gz9ts9OHXZG6q3elQUCVW5zODX7WZ4SwLP8jTnlaZ+Par1uZiRcPJiNt18Z7Taen+rgI0F
 XpYci3MiOi9VMTNisISZliWhupjF67aFZhLqrd1a4xVr6xGaz776jPQmpujoNYwGyPzwlG
 hbb2RyBoiIHKFsuHy45VuCcHcG9U65I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Qp6YCaQ2OVO12gVbj_ZxQw-1; Fri, 24 Nov 2023 04:27:53 -0500
X-MC-Unique: Qp6YCaQ2OVO12gVbj_ZxQw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-540150414efso1066728a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 01:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700818072; x=1701422872;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHe6APctkLt0R9Ty4iBGvLnpq2axVP2/KRFfGx5vSrA=;
 b=elAZLtw1zUYyipFaEIsabrEILsVlq9tnf9LstIfl7UMYgi7c/WI4z8u13AnJKbyNUR
 LinPrJUjxEN1zyv1Yl/MuyPEzJgCKUNs/vJxnkoNhwL7a1P4Zw5hGgDei+OMAqBhRtTV
 c6SqaUK2zdj+RiBbw23EizqW2sHeI71ivZVJogb4Y+tnhumjStPoH3Zn531ZnUGfV9Em
 fwLxcOjAX7DPAqLsD0J4tkdvqOfEXoE52a4Gzyz9z4L+Drc32fd/bemeGA5DF4lPLkkK
 sKpi8gzeGtD/dONmgP+72YHewXdr7b8MVepzIc00PtL2bfXkZKt5xiWxIZ4lcelFEhE+
 ULeg==
X-Gm-Message-State: AOJu0YxasQ32gu8zUc0NJaT44woxq766rbaAeRBJVA/9pOcKpa/YMKEF
 qrY0l/IbL/2NiQyMg1RIyC4RF88icdmFq/NKerxUI2swktnbFW/vUxp7EuezPg9kUKEYRl9jljm
 UdapTYobgVuPQSNs=
X-Received: by 2002:aa7:c608:0:b0:54a:f1db:c2b8 with SMTP id
 h8-20020aa7c608000000b0054af1dbc2b8mr1175710edq.6.1700818072186; 
 Fri, 24 Nov 2023 01:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3rZAzyIJjAvVVxRMF3MvKev1Vb2kzvha7JKZxRWqhMvTOeML9dRKZDTtexVG3FpgKN0sS+A==
X-Received: by 2002:aa7:c608:0:b0:54a:f1db:c2b8 with SMTP id
 h8-20020aa7c608000000b0054af1dbc2b8mr1175693edq.6.1700818071827; 
 Fri, 24 Nov 2023 01:27:51 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 u3-20020a056402110300b0053f10da1105sm1565630edv.87.2023.11.24.01.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 01:27:51 -0800 (PST)
Date: Fri, 24 Nov 2023 04:27:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124041343-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <ZV-S1f2cK8MLNizz@redhat.com>
 <20231123172828-mutt-send-email-mst@kernel.org>
 <ZWBngLoa3ERuMxGJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWBngLoa3ERuMxGJ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Fri, Nov 24, 2023 at 09:06:29AM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 23, 2023 at 05:39:18PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 23, 2023 at 05:58:45PM +0000, Daniel P. Berrangé wrote:
> > > The license of a code generation tool itself is usually considered
> > > to be not a factor in the license of its output.
> > 
> > Really? I would find it very surprising if a code generation tool that
> > is not a language model and so is not understanding the code it's
> > generating did not include some code snippets going into the output.
> > It is also possible to unintentionally run afoul of GPL's definition of source
> > code which is "the preferred form of the work for making modifications to it". 
> > So even if you have copyright to input, dumping just output and putting
> > GPL on it might or might not be ok.
> 
> Consider the C pre-processor. This takes an input .c file, and expands
> all the macros, to split out a new .c file.
> 
> The license of the output .c file is determined by the license of the
> input .c file. The license of the CPP impl (whether OSS or proprietary)
> doesn't have any influence on the license of the output file, it cannot
> magically force the output file to be proprietary any more than it can
> force it to be output file GPL.
> 
> With regards,
> Daniel

Sorry I don't get how is C preprocessor relevant here? It does not
generate source code in the GPL sense. We won't accept C preprocessor
output in a patch.

Not being a lawyer I personally am not really interested in discussing
how copyright works, certainly not at this highly abstract and
simplified level.

-- 
MST


