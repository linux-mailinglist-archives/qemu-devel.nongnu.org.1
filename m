Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177217F619E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6AoB-0007WZ-SC; Thu, 23 Nov 2023 09:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Ao6-0007VN-Cg
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Ao4-0001fG-KC
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700750151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sa3UQ52pYQGz5FtIsLcMT3tghmjaTMc1yNSw1NmZS34=;
 b=X0LkQGU9uxoK5zUJF9Ea7ptINstG182vrgtRO1bKkyUU2PP9wN8Y7KMzv/OciuInPKIbN9
 RVuukorUFNjKJSAeQr9XW0INXxAOWXy64S7t1yYPtUXPHrDJt5Rm0Wiw0IKkDM0EOtZsh6
 v/pLK3A4YpfDRajC56fxhTqQW8V4Lr4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-_9uPB5cMPpKBHEFqonmudw-1; Thu, 23 Nov 2023 09:35:50 -0500
X-MC-Unique: _9uPB5cMPpKBHEFqonmudw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c51d0f97e3so8372171fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750149; x=1701354949;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sa3UQ52pYQGz5FtIsLcMT3tghmjaTMc1yNSw1NmZS34=;
 b=VgTHwHNJSE/iboVbkLPXm1UfG0kUI4ujjY6D6x7+Hwh94rGVANRtr+eFHaWdVL88Fi
 0z+ctTUnjtN4kXlbDV9yi/97bC5L/OtnSepyOuioipqL5HE0GIXwJDXoQo8YYzoUxNtM
 2DIrSvhgK/JBXMjrfC4Z1mCHJXfj5akMMkq2C4n1e5KBvR7kucVkQd31H90EWv81u5Lc
 Bfhx7VPbDzYTaQiWYinZsQFEQJde0V2WpiUp1rAHOCsH9Ux7A/vVTk+1iVasqxpEHeQw
 7BcYZWV4e1LflLeMk7paTD700ZJ4zHA467/bKp50y772pvWdveEd6gh2kn/0cxu+nrg1
 MeXg==
X-Gm-Message-State: AOJu0YzhJ0oZPFyz+fXUSbqDAQxMvgFJim2sn5fwA74k6+cQ+5L9hN8Y
 vvNc/VCZHMIbac1uPQXTXOKE/Qm5WETU9rphNIsZzhV8GDRcisg3AM9staGYR4EQleHNl0OPju1
 Awa6jytSXtPHMRVM=
X-Received: by 2002:a2e:9698:0:b0:2c5:1b82:a533 with SMTP id
 q24-20020a2e9698000000b002c51b82a533mr3780323lji.15.1700750148729; 
 Thu, 23 Nov 2023 06:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJXPGtDOzm7Vcre/isuTllqP96cjzJQiet7ZtNM+sx+BOaR3AJhD7nxAkjQ4QTzG4IIqgqAw==
X-Received: by 2002:a2e:9698:0:b0:2c5:1b82:a533 with SMTP id
 q24-20020a2e9698000000b002c51b82a533mr3780304lji.15.1700750148342; 
 Thu, 23 Nov 2023 06:35:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a05600c4f5300b0040b2b38a1fasm2250367wmq.4.2023.11.23.06.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 06:35:47 -0800 (PST)
Date: Thu, 23 Nov 2023 09:35:43 -0500
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
Message-ID: <20231123092523-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123114026.3589272-3-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrangé wrote:
> There has been an explosion of interest in so called "AI" (LLM)
> code generators in the past year or so. Thus far though, this is
> has not been matched by a broadly accepted legal interpretation
> of the licensing implications for code generator outputs. While
> the vendors may claim there is no problem and a free choice of
> license is possible, they have an inherent conflict of interest
> in promoting this interpretation. More broadly there is, as yet,
> no broad consensus on the licensing implications of code generators
> trained on inputs under a wide variety of licenses.
> 
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack
> of consensus on the licensing of "AI" (LLM) code generator output,
> it is not considered credible to assert compliance with the DCO
> clause (b) or (c) where a patch includes such generated code.
> 
> This patch thus defines a policy that the QEMU project will not
> accept contributions where use of "AI" (LLM) code generators is
> either known, or suspected.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index b4591a2dec..a6e42c6b1b 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -195,3 +195,43 @@ example::
>    Signed-off-by: Some Person <some.person@example.com>
>    [Rebased and added support for 'foo']
>    Signed-off-by: New Person <new.person@example.com>
> +
> +Use of "AI" (LLM) code generators
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +TL;DR:
> +
> +  **Current QEMU project policy is to DECLINE any contributions
> +  which are believed to include or derive from "AI" (LLM)
> +  generated code.**
> +
> +The existence of "AI" (`Large Language Model <https://en.wikipedia.org/wiki/Large_language_model>`__
> +/ LLM) code generators raises a number of difficult legal questions, a
> +number of which impact on Open Source projects. As noted earlier, the
> +QEMU community requires that contributors certify their patch submissions
> +are made in accordance with the rules of the :ref:`dco` (DCO). When a
> +patch contains "AI" generated code this raises difficulties with code
> +provenence and thus DCO compliance.
> +
> +To satisfy the DCO, the patch contributor has to fully understand
> +the origins and license of code they are contributing to QEMU. The
> +license terms that should apply to the output of an "AI" code generator
> +are ill-defined, given that both training data and operation of the
> +"AI" are typically opaque to the user. Even where the training data
> +is said to all be open source, it will likely be under a wide variety
> +of license terms.
> +
> +While the vendor's of "AI" code generators may promote the idea that
> +code output can be taken under a free choice of license, this is not
> +yet considered to be a generally accepted, nor tested, legal opinion.
> +
> +With this in mind, the QEMU maintainers does not consider it is
> +currently possible to comply with DCO terms (b) or (c) for most "AI"
> +generated code.
> +
> +The QEMU maintainers thus require that contributors refrain from using
> +"AI" code generators on patches intended to be submitted to the project,
> +and will decline any contribution if use of "AI" is known or suspected.
> +
> +Examples of tools impacted by this policy includes both GitHub CoPilot,
> +and ChatGPT, amongst many others which are less well known.


So you called out these two by name, fine, but given "AI" is in scare
quotes I don't really know what is or is not allowed and I don't know
how will contributors know.  Is the "AI" that one must not use
necessarily an LLM?  And how do you define LLM even? Wikipedia says
"general-purpose language understanding and generation".


All this seems vague to me.


However, can't we define a simpler more specific policy?
For example, isn't it true that *any* automatically generated code
can only be included if the scripts producing said code
are also included or otherwise available under GPLv2?




> -- 
> 2.41.0


