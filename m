Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1C7F719B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:38:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TZD-0006yx-GG; Fri, 24 Nov 2023 05:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6TZC-0006yo-5r
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6TZ7-000404-D7
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700822260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNVeoT7Yh/IaOQAQ0MLGHSDmYn8lPtpAOgzVL2WZYQk=;
 b=PjnjZr8rna9SUyA7bjUplyyQ9wycqKJ7QnPxA9whgzi2Ss6wBVp6C33UI0L5Y2ebBUUTbY
 mumqTZW/w8rEA2NscIeJgUbTU44se7G81wm9N6CKj7ou2T6xyC2iK7vYYtJ2XGGUx5Hoo3
 Q3ja9FWsvlqSr3dlwCjxbl/053wehqU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ywFPV7vbOnifwZN7cnMt_w-1; Fri, 24 Nov 2023 05:37:32 -0500
X-MC-Unique: ywFPV7vbOnifwZN7cnMt_w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9fffa4c4f28so115446266b.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822251; x=1701427051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNVeoT7Yh/IaOQAQ0MLGHSDmYn8lPtpAOgzVL2WZYQk=;
 b=JrErRwyvY01W9jDru1cjMdHRQWvGiAbMYVEADkHP7uREu+U/3SI5yvgd3bKKWPOVOD
 MezZ+GUp2AvZ6WFbPt1zXSIsZ92CelE4ERDA9V9bj1r6EksnIV1JaisE4CZ+B+x7srTn
 aB2+qvHTXIHdEkRhMH68fsnpJIedd2bhr13939lSK6dPt0fobxtrPvPvU7GGsO6EecQ7
 9UnPmmc3xgc3097YA0O6wHr1t5txze54LG7n0lqZ0uO7z1EP8tBVp6RMnQmCFnnP5KqB
 fZSoX9FbDuC8rHQ6IoEuE3tVbvXkF8ZlV1I6/feTcGIE3ShLy6GXls8iPzq2JP7C5nXC
 Q5pQ==
X-Gm-Message-State: AOJu0YzSuDrEY8TOi17DJrWeD4U1QhTJaiQqG2pbkhEojwoLWnK4aIaO
 /Z6VCEA847JQHRQbQCerXnhaY9HN1hQUER/6elIOz5CxJEDC9LHQeHNJtlXidqSdBcJmRYpp7ae
 l4OTJ34/TJzaLUmE=
X-Received: by 2002:a17:906:12:b0:a02:b538:1720 with SMTP id
 18-20020a170906001200b00a02b5381720mr1643515eja.3.1700822251203; 
 Fri, 24 Nov 2023 02:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMoQ+0xGlQgemmIb1fK8VGa9h97/5OSRtvx8AwZ0NHbIC75ebiFkOuFy5yjtwMV4oVtdOs7g==
X-Received: by 2002:a17:906:12:b0:a02:b538:1720 with SMTP id
 18-20020a170906001200b00a02b5381720mr1643490eja.3.1700822250799; 
 Fri, 24 Nov 2023 02:37:30 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 bv8-20020a170906b1c800b009fc927023bcsm1893751ejb.34.2023.11.24.02.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:37:30 -0800 (PST)
Date: Fri, 24 Nov 2023 05:37:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124053116-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org> <ZWB6M6w9yqAeemyi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWB6M6w9yqAeemyi@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Nov 24, 2023 at 11:25:55AM +0100, Kevin Wolf wrote:
> > - Automated codegen tool must be idempotent.
> > - Automated codegen tool must not use statistical modelling.
> 
> How are these definitions related to your ability to sign the DCO?

Not only that - while the question of whether code generated e.g. by copilot
would be source code by GPL definition is unclear at least to me,
code generated by an idempotent automated tool seems highly
likely not to satisfy the GPL definition.
Though I am not a lawyer and do not speak for Red Hat.

-- 
MST


