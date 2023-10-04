Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D47B8607
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5F5-000563-JQ; Wed, 04 Oct 2023 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo5Es-00054t-2p
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo5El-0003uF-Fa
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438836;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfhnVzbJctGN+gGkebJQNKU0GANU6NIvRE3DYYRLpaI=;
 b=YwfqBmCi1Q3jYPW2tUwdvBDOtcZ0yERv2gpHoGCaLPixO2xuKGFABa8mru3UAZ6uRcHdWI
 cIhgPwEynLrSRK4BrVXbBSFuE3nPb3hi1h2kQDYJr3gWyheuKGUZvj02Q53sWEU4ricl8m
 ZbK0a29qRgv5okUoGhnobPMZlgWjljw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-YfLs0Q5bPaOLBjGTv0pICg-1; Wed, 04 Oct 2023 13:00:29 -0400
X-MC-Unique: YfLs0Q5bPaOLBjGTv0pICg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77409676d7dso1741485a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438829; x=1697043629;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfhnVzbJctGN+gGkebJQNKU0GANU6NIvRE3DYYRLpaI=;
 b=dDccA7mYEg9WJksSbQj2zdl5qRVzaW6XJa5SB5tm50vt3xVbOg8/5pM86Tnmx6Z+/B
 MGE2Qb56KKSFtDrPwrj+s6rdKyme5WBzKAyp6ITH/ip5E5WmtKrkVErySDMVcbr//bh4
 9CJZLRFheSOnARFsM7Bw/MyJfBNsLrg8Eu3Obs58ui3j3jZBnDZlwIblZvruB3DDyyCH
 qqyD3lr5LU/effrDXcP2JrNMoFEm0o2O0RW26d9/IkpkUt9Tog8HCk9j7ib5rRqI8rci
 5F9ZAxVCRSh0xVbjAjs3dR4OCSJgg+CM1cadf8HQdyIJbagi5TwS8RcVP5+fTpTbmCeM
 tQIg==
X-Gm-Message-State: AOJu0YyjiICHf6xkJ+mflgLitc3Zlxnl6OGeOxsdFsLtKShOooTGXFGv
 8FpF+En9/bjPF6zpjrZTpVpBdwCYqRTHERtPwKnrxe0yYoM9tp1UDinfOiNkGTWJ+cmKXLMdahZ
 vPW9LtODdF0Nkwp4=
X-Received: by 2002:a05:620a:141a:b0:774:1f74:fe2c with SMTP id
 d26-20020a05620a141a00b007741f74fe2cmr3034457qkj.21.1696438829374; 
 Wed, 04 Oct 2023 10:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyjrsNcQEbOCcEQpWiuKoAo0hirOdkO0DnhbmblIb5JGGLuxfRC7rPNNwT+OPlwC1P6zYpxQ==
X-Received: by 2002:a05:620a:141a:b0:774:1f74:fe2c with SMTP id
 d26-20020a05620a141a00b007741f74fe2cmr3034440qkj.21.1696438829142; 
 Wed, 04 Oct 2023 10:00:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05620a079300b007742c6823a3sm1390988qka.108.2023.10.04.10.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:00:26 -0700 (PDT)
Message-ID: <f50737da-af8c-ff3a-2e4b-1ae0327a422c@redhat.com>
Date: Wed, 4 Oct 2023 19:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 13/15] vfio/common: Store the parent container in
 VFIODevice
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-14-eric.auger@redhat.com>
 <79fb6650-783c-f9d7-4294-668bebe23fe0@redhat.com>
 <4098f81f-bb7c-bbcb-4d73-04e3981a08f5@redhat.com>
 <52120fe3-1647-1513-b005-f5099c16a862@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <52120fe3-1647-1513-b005-f5099c16a862@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 10/4/23 18:55, Cédric Le Goater wrote:
> the device-introspect-test needs it. No need to resend a v5, I can add it
> back in v4 if you are ok with that. 

Ah OK. I am definitively OK for you to restore it if nothing else shows
up inbetween

Eric


