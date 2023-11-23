Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15A7F6982
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 00:28:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6J6h-0007G7-Kb; Thu, 23 Nov 2023 18:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6J6f-0007DU-II
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 18:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6J6e-0006DG-1C
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 18:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700782054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdFqhi/Q3D00/TuxMDEJvf3RTBlgDVVUOv11xb1lSjc=;
 b=C/efnGFEFJXWy73TjVx3B/vxus+iYDUu6CQoas/Hr8mMTOWNF0gW7z1qD27rUmAqNk3ono
 S1TRi0fzRai7PASAxoAScIQew5xQv8lWLq9/f/1Gsu6rv0SWqaOLtYWBmNzcgG1ImdyAiC
 TLJBYFUZpWRJDV9nY86h8cnFlf/veNU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-z3nxYMu_O9-KgV38MzS9Cg-1; Thu, 23 Nov 2023 18:27:32 -0500
X-MC-Unique: z3nxYMu_O9-KgV38MzS9Cg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a03337f7851so89241766b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 15:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700782051; x=1701386851;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdFqhi/Q3D00/TuxMDEJvf3RTBlgDVVUOv11xb1lSjc=;
 b=PYOhPgGwHh0nhbCQeuCsmRGEZzuhszD7SKrBx411gL4kXlWIOYr8NnhAqwdkMCXxAV
 yZbZ/R6Z27/1l3Bsyv/rFuuuf7xlfJY2vsW3HgNau7N23eJ6pF8VL0Gt3fRmO2fpbzNK
 jaX6e0b09DB6fyN0AJgUpuWmgNEbQVD6pqye9TIaerPCvZVBdkbhQ22t+Zd6R6klOsqK
 8/JcRMGSHFpzOv46SDsSHDORLthYt26jezFF/jcVNufpjYcxGSgFyBXU2jl8p1HcMZ4/
 l/4opYQmMKegLsvK5oPVVGHzlBJY2dTuKA+gLFzr8z6dFkdfZu2RVpY2+AShKlDavmjO
 9i+w==
X-Gm-Message-State: AOJu0YzuvfrEu2UeY0dRB+Bm/CVTD4XHAi2dc1aqkRFXwIztLHSdy15U
 2Jj5Mf4Y9/Vswf0ZiM4MmdnmpxOhXpUvOqFEq0XC7PehIZaPcK1NUQ6BglclauPRhv67JvHXz43
 hSpV6UZnUhuHbQQg=
X-Received: by 2002:a17:906:1019:b0:9ff:dad:de15 with SMTP id
 25-20020a170906101900b009ff0dadde15mr524354ejm.50.1700782051451; 
 Thu, 23 Nov 2023 15:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhceGYrmAC/xQnCYhaT+xdke58xf8Q8A1hamtF8VwfSIzMpB9I+OR9i5zGxRd/S03GAh6uHQ==
X-Received: by 2002:a17:906:1019:b0:9ff:dad:de15 with SMTP id
 25-20020a170906101900b009ff0dadde15mr524335ejm.50.1700782051108; 
 Thu, 23 Nov 2023 15:27:31 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 q18-20020a1709060e5200b00992f2befcbcsm1303737eji.180.2023.11.23.15.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 15:27:30 -0800 (PST)
Date: Thu, 23 Nov 2023 18:27:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123180304-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org>
 <20231123173747.GV9696@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123173747.GV9696@kitsune.suse.cz>
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

On Thu, Nov 23, 2023 at 06:37:47PM +0100, Michal Suchánek wrote:
> If you could erase the copyright on anything by feeding it into a
> statistical model and pulling it back out there
> Would be some big
> content license holders objecting so it's very unlikely to happen.

I won't venture a guess and I think neither should QEMU.  For now, being
on the safe side and rejecting auto-generated code sounds very
reasonable to me, though, in particular because it's often
quite low quality ;).

Not a lawyer, and I don't speak for Red Hat.
-- 
MST


