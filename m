Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16531739D9D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:46:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGsw-0008Sa-AH; Thu, 22 Jun 2023 05:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGsk-0008Qp-9i
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGsg-0002gt-9n
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687427133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqDU0eg+pczPtGb1MNYxfNystMrl6imoFdmyIpUqMtk=;
 b=ZwImgBGmBFRcOnd0iilUy9hK8GGubvDVZBVhs1/xwuoKPiMqHzdrrPakrOIS1Y20bp0SH5
 sajqoqH/8B8fwTQeTze/iJXG5qNcpw695E+Bqidg5OzP+TvFXc4NAUZRU1WPn1y7j/TEtJ
 yMjvL+CGtpj+visu2ZVm4Y0yX/Oe/vU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-ipu84kkhMQOCZMLsq25tLA-1; Thu, 22 Jun 2023 05:45:31 -0400
X-MC-Unique: ipu84kkhMQOCZMLsq25tLA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-986db3313f0so401127366b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427130; x=1690019130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GqDU0eg+pczPtGb1MNYxfNystMrl6imoFdmyIpUqMtk=;
 b=gPG17ccqg8Do5IUf+LtIgdzImnPcm0C9Jaj37OfpEh2tK/9sFr3ytYxRb58/3chcFE
 ZeYblUJ/lxJLKud9xbakbzySamiywQ50bSTFf5U5Yqf9GKuAvW8Dt+1RDZUqHVKsrifx
 JpmawyZmGTp8l8dr2yJLeau94nKUz0yU6G7y+VixMpSu0Cawz+vpuQp1xZdtD0Ieb+0y
 KnZn4pRA52aopjkT3llMDUNSFB3Fhvmmbryhc/0VRt8esJGJ585nokv0I2FpOGTtpmou
 VizqtBj9KwvgmEd0i3tbzqkGw4ZqLigEJYcH6XDJn0GG3cV7HzI6uX0SelPqJRqAEbrF
 U7ug==
X-Gm-Message-State: AC+VfDyi17JxrVyYq5CudRxyiv72Ap8gy5eVjStPUZ9hxfEIFtNy+9Gw
 Y/GvRYGykvkt6FTamS+4FLcQV9oP1PURqYbXZ644OqICqng7ZO21WI7hGBUpY5yyE8CX+VDbN/+
 zMTEoWofbKCJ+kNQ=
X-Received: by 2002:a17:907:9491:b0:982:9fbb:216 with SMTP id
 dm17-20020a170907949100b009829fbb0216mr15800734ejc.19.1687427130251; 
 Thu, 22 Jun 2023 02:45:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sJZRUKpFAZHzXIKWam2PUyoh4RPPBzqw/fKBDo8WgqcvyPoYMtEU91Qw+i4baQMP+IjsY/A==
X-Received: by 2002:a17:907:9491:b0:982:9fbb:216 with SMTP id
 dm17-20020a170907949100b009829fbb0216mr15800719ejc.19.1687427129833; 
 Thu, 22 Jun 2023 02:45:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 e19-20020a50fb93000000b0051a44a5636asm3688290edq.44.2023.06.22.02.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:45:29 -0700 (PDT)
Message-ID: <59f958ac-807d-e940-e5de-8109de62eb8c@redhat.com>
Date: Thu, 22 Jun 2023 11:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Content-Language: en-US
To: quintela@redhat.com
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87wmzv7ubn.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


On 6/22/23 10:52, Juan Quintela wrote:
> User friendliness.
> The problem is that if you use more than two channels with multifd, on
> the incoming side, you need to do:

You're sacrificing user-friendliness for the 99.99% that don't use 
multifd, for an error (i.e. it's not even fixing the issue) for the 
0.01% that use multifd.  That's not user-friendly.

> - migrate_set_parameter multifd-channels 16
> - migrate_incoming <uri>
> 
>> The issue is not how many features the command line has, but how
>> they're implemented.
> 
> Or if they are confusing for the user?

Anyone using multifd is not a typical user anyway.

>> If they're just QMP wrappers and as such they're self-contained in
>> softmmu/vl.c, that's fine.
>>
>> In fact, even for parameters, we could use keyval to parse "-incoming"
> 
> What is keyval?

util/keyval.c and include/qemu/keyval.h.  It parses a list of key=value 
pairs into a QDict.  Once you have removed the "source" key from the 
QDict you can use a visitor to parse the rest into a 
MigrateSetParameters.  See the handling of QEMU_OPTION_audio, it could 
be something like


             case QEMU_OPTION_incoing: {
                 Visitor *v;
                 MigrateSetParameters *incoming_params = NULL;
                 QDict *dict = keyval_parse(optarg, "source", NULL, 
&error_fatal);

                 if (incoming) {
                     if (qdict_haskey(dict, "source")) {
                         error_setg(&error_fatal, "Parameter 'source' is 
duplicate");
                     }
                 } else {
                     if (!qdict_haskey(dict, "source")) {
                         error_setg(&error_fatal, "Parameter 'source' is 
missing");
                     }
                     runstate_set(RUN_STATE_INMIGRATE);
                     incoming = g_strdup(qdict_get_str(dict, "source"));
                     qdict_del(dict, "source");
                 }

                 v = qobject_input_visitor_new_keyval(QOBJECT(dict));
                 qobject_unref(dict);
                 visit_type_MigrateSetParameters(v, NULL, 
&incoming_params, &error_fatal);
                 visit_free(v);
                 qmp_migration_set_parameters(incoming_params, 
&error_fatal);
                 qapi_free_MigrateSetParameters(incoming_params);
             }


For example "-incoming [source=]tcp:foo,multifd-channels=16" would 
desugar to

   migrate_set_parameter multifd-channels 16
   migrate_incoming tcp:foo

The only incompatibility is for people who are using "," in an URI, 
which is rare and only an issue for the "exec" protocol.

Paolo

>> and
>> set the parameters in the same place as above.  That would remove the need
>> for "-global migration".
> 
> Could you elaborate?



> The other option that I can think of is changing the error messages for
> migrate_check_parameters() and give instructions that you can't set
> multifd channels once that you have started incoming migration.
> Explaining there to use migrate_incoming command?
> 
> Later, Juan.
> 
> 


