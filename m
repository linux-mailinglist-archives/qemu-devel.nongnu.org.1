Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A477C555F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCx-00073B-Hr; Wed, 11 Oct 2023 09:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZCl-0006z8-40
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZCj-0004Y1-6s
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d7pSh5tV++KOSfn2OtXyAyqBgjXkhZWhjy+xxx7qOLc=;
 b=Tsg7w3wbV0eBiErLJZmxx3wEoqJ1N7gUHgpfnyeuTMADwlkbUt3GJKApaFoRLUBcgzX7Ew
 98yJw96k8a+mJkNNbJ+VX/+vRqRSL9yqrr9tJL4RtGaq0G2+IQWnBpAG9XMwUAmP0oiJhX
 DDc6oztp6UU+LnlQ4N57tNqpc9J6BaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-e_eVL3UeN-6tXsebfjSiHg-1; Wed, 11 Oct 2023 09:24:37 -0400
X-MC-Unique: e_eVL3UeN-6tXsebfjSiHg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3231f43fc5eso4627333f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030675; x=1697635475;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7pSh5tV++KOSfn2OtXyAyqBgjXkhZWhjy+xxx7qOLc=;
 b=uPEe/xs0lpeN4VbefVRxjbGFb9n6/qn35gweD7M7+lsM9u6zeNVbJI6h65o69YkvDx
 aHIsBD6mKyUU5N91jSmONrXXq2I3bjEYc2BEkJXJ75F4MbM9zY7MH5S6k4nEONFjN+DJ
 L2PsFvLjoauWMPLotH9DR+5DzfeSII1aNdjnujuJC4J90njXvv3Wbm1kQmeVQ041YTkC
 rJD91szRrZ+LhPzK8LubYDZKAysZQcgpTFA32PrFoo/5OeS3L2OESUQC1uavXPQTsZMv
 ke/MOI/jPeQoPbRLTLIQiuSBBNObUf/qan7SWK8+NVld+ZHESAU24GocUPfRcjgNmGOA
 4TEg==
X-Gm-Message-State: AOJu0Yx7okWYyWVJDuwAqF/k2TZxIusgm+4GsgKi/FtYAXM4QtJcewV6
 o3ZuOOMvHTbN4n5P2YoT4p+Lv4uw854moyMZ9qjGoUdHJm+kXAcMruDxowakqQd2bW95k0TwLpO
 Yo6e9iNKxUrcyYaA=
X-Received: by 2002:adf:f74c:0:b0:320:aea6:abb9 with SMTP id
 z12-20020adff74c000000b00320aea6abb9mr17503436wrp.6.1697030675085; 
 Wed, 11 Oct 2023 06:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcIcRkUnKOtaxbK/X13TIgBle8PdMh41BHxmvrVBis/7Hem/8uBDd2CsJpEe0ainqZUB0Alg==
X-Received: by 2002:adf:f74c:0:b0:320:aea6:abb9 with SMTP id
 z12-20020adff74c000000b00320aea6abb9mr17503420wrp.6.1697030674763; 
 Wed, 11 Oct 2023 06:24:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfa347000000b0032d72f48555sm236520wrb.36.2023.10.11.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:24:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 5/6] migration: Fix analyze-migration read operation
 signedness
In-Reply-To: <20231009184326.15777-6-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:25 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-6-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:24:33 +0200
Message-ID: <87r0m19tri.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The migration code uses unsigned values for 16, 32 and 64-bit
> operations. Fix the script to do the same.
>
> This was causing an issue when parsing the migration stream generated
> on the ppc64 target because one of instance_ids was larger than the
> 32bit signed maximum:
>
> Traceback (most recent call last):
>   File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 658, in <module>
>     dump.read(dump_memory = args.memory)
>   File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 592, in read
>     classdesc = self.section_classes[section_key]
> KeyError: ('spapr_iommu', -2147483648)
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


