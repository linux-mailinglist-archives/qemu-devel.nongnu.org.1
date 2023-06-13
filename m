Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46572EA73
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 20:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98Mh-0003sn-Hg; Tue, 13 Jun 2023 14:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98Mf-0003sO-I5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98Me-0004u7-0s
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686679410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4im4cEQwh1voYXMsaMWNtDpSmVXFd2l+MaDEUIpirr4=;
 b=HAc6XxJ0vJWR6nb1fRAQe/pPepOQeF0AD8CwkQrdgILhSkiJzDFYe6v+a3sGmWdT3cpLbO
 LBasMCmFSQwOw2INjm7uTMfAkOt207km/RKkhkyVx6EDXIt0LU0+mpFZTXWgAvwiT4Y29s
 e/FYKVRjgf+we+ACBYc5BKSlp7bem84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-e_X8ylIYOZeXOqNs7eetyg-1; Tue, 13 Jun 2023 14:03:29 -0400
X-MC-Unique: e_X8ylIYOZeXOqNs7eetyg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7678c74beso37349255e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 11:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686679402; x=1689271402;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4im4cEQwh1voYXMsaMWNtDpSmVXFd2l+MaDEUIpirr4=;
 b=O6uUsVh5L+me+UnRS/JNm0K/DjhuSHYQ1A6gB9PRWg6ef3fH2Vo+KgIvDkMe0JTimM
 C6Pl3TCyGz8UjQBSCURkGHoHM0a4goPLzsgKZ/PFWYymdGKdHRmh06yTHIPoAxlB2z5l
 KDN+Y35bS0kUPiELECf+7d7sSaiHyoflvaa4Dmy5iRXfMgI/xs51ulYpDkYpYJu3VkeV
 h6R/W8psBPcevO+TrEN6pxK19O1cE37LSi/umizA5AQE4DSlawAoErzMqoju6jiVIhUh
 up1k1eNrXTD9mGpL5YygURnWZ0oHp4sN/mt77T+BK+WuxE4MhVUsnF1oMgufcPd3FAOv
 RClw==
X-Gm-Message-State: AC+VfDwTDVRMPhMj8z05CGZoZxtBMvHBmwqOG640Yf/Cqzl+b0IRCweH
 FXr6Y9dOJ9M/7z7gacnohjDbiSi+ZNP2Oj0dFZE8p7/NOjl1dSa2e7dMM8TS/xfdDmFrjX/Ao7o
 Vot/nzY5lNQPds54=
X-Received: by 2002:a7b:ce8a:0:b0:3f7:b6d9:46a0 with SMTP id
 q10-20020a7bce8a000000b003f7b6d946a0mr10649458wmj.30.1686679402347; 
 Tue, 13 Jun 2023 11:03:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CgO33IYC7johbq4o8oFO6Fdn/QJKBI/M9sforpHwpP7LvFWc89dtW9PwEn/X+v1/JxbFhFw==
X-Received: by 2002:a7b:ce8a:0:b0:3f7:b6d9:46a0 with SMTP id
 q10-20020a7bce8a000000b003f7b6d946a0mr10649440wmj.30.1686679402071; 
 Tue, 13 Jun 2023 11:03:22 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c021200b003f8d6647661sm1001198wmi.15.2023.06.13.11.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 11:03:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 7/8] migration: Extend query-migrate to provide
 dirty page limit info
In-Reply-To: <168618975839.6361.17407633874747688653-7@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:21:58 +0800")
References: <168618975839.6361.17407633874747688653-7@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 20:03:20 +0200
Message-ID: <87mt13ck9j.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Extend query-migrate to provide throttle time and estimated
> ring full time with dirty-limit capability enabled, through which
> we can observe if dirty limit take effect during live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


