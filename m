Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B793C7A7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jul 2024 19:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX2FT-0001Dw-6X; Thu, 25 Jul 2024 13:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sX2FQ-0001BJ-Ge; Thu, 25 Jul 2024 13:27:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sX2FO-0004UX-29; Thu, 25 Jul 2024 13:27:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PGx5de008267;
 Thu, 25 Jul 2024 17:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
 cXD8mrlQm0r760RRfW2u8dmOygc2IBecVUmUxah4Ss=; b=GJ7lJRaOaQMXC1cpK
 LvWiX8K5h8fLPG0QkxZb1JDj9vdeFktGV3uh+CtpPnAQbCdI+RFcWwHniacF8e5u
 4oj+jyUa6uvZrngINEV7oC3eebFm4JWyJ7Rt1DoDxvKQORZxoljSkrI2ccRzce3f
 ZzXSO/iY6egDkVvwHn42jfed8V32ES9uwEdi6WcqBJgbO1m2TM/fGh2jAb4QLOOx
 cCnJW7pJNMIWNY8ZQ+NFbsX3n29S2vZOTe/KNniFwVmeU/dW2HbL9veJrAKkaNN4
 CB11drNa0c+JwAG9C+Ih4FePrIs7ZaDco+cYajiZUuexSt1CujBAZW9LU9QFUxED
 N5X6w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ktpsg2bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 17:27:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46PHREiU025151;
 Thu, 25 Jul 2024 17:27:14 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ktpsg2be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 17:27:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46PHJ67X007070; Thu, 25 Jul 2024 17:22:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72xvkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 17:22:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46PHMRJO48562464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2024 17:22:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 814B858061;
 Thu, 25 Jul 2024 17:22:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED7E458057;
 Thu, 25 Jul 2024 17:22:26 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jul 2024 17:22:26 +0000 (GMT)
Message-ID: <fa452b18-d19c-4d00-a566-3ec82d53b153@linux.ibm.com>
Date: Thu, 25 Jul 2024 13:22:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
 <87cyn2ugyi.fsf@pond.sub.org> <87v80tudo7.fsf@pond.sub.org>
 <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W0AqI0YBSad4lD2DH2dHf28LP_epel1D
X-Proofpoint-ORIG-GUID: pW01jwoufVLeoGflFqRnJKCqVCsKaDvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_15,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/25/24 3:39 AM, David Hildenbrand wrote:
> On 25.07.24 09:35, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> On 7/24/24 3:56 AM, Markus Armbruster wrote:
>>>>> Collin Walling <walling@linux.ibm.com> writes:
>>>> Let me try to explain the purpose of @deprecated-props and see if it
>>>> helps bring us closer to some semblance of a mutual understanding so we
>>>> can work together on a concise documentation for this field.
>>>>
>>>> s390 has been announcing features as deprecated for some time now, which
>>>> was fine as a way to let users know that they should tune their guests
>>>> to no longer user these features.  Now that we are approaching the
>>>> release of generations that will drop these deprecated features
>>>> outright, we encounter an issue: if users have not been mindful with
>>>> disabling these announced-deprecated-features, then their guests running
>>>> on older models will not be able to migrate to machines running on newer
>>>> hardware.
>>>>
>>>> To alleviate this, I've added the @deprecated-props array to the
>>>> CpuModelInfo struct, and this field is populated by a
>>>> query-cpu-model-expansion* return.  It is up the the user/management app
>>>> to make use of this data.
>>>>
>>>> On the libvirt side (currently in development), I am able to easily
>>>> retrieve the host-model with a full expansion, parse the
>>>> @deprecated-props, and then cache them for later use (e.g. when
>>>> reporting the host-model with these features disabled, or enabling a
>>>> user to define their domain with deprecated-features disabled via a
>>>> convenient XML attribute).
>>>>
>>>> tl;dr @deprecated-props is only reported via a
>>>> query-cpu-model-expansion, and it is up to the user/management app to
>>>> figure out what to do with them.
>>>
>>> Got it.
>>>
>>> Permit me a digression.  In QAPI/QMP, we do something similar: we expose
>>> deprecation in introspection (query-qmp-schema), and what to do with the
>>> information is up to the management application.  We provide one more
>>> tool to it: policy for handling deprecated interfaces, set with -compat.
>>> It permits "testing the future".  See qapi/compat.json for details.
>>> Whether such a thing would be usful in your case I can't say.
>>>
>>>>> On closer examination, more questions on CpuModelInfo emerge.  Uses:
>>>>>
>>>>
>>>> I will attempt to expand on each input @model (CpuModelInfo) as if they
>>>> were documented in the file.
>>>>
>>>>> * query-cpu-model-comparison both arguments
>>>>>
>>>>>    Documentation doesn't say how exactly the command uses the members of
>>>>>    CpuModelInfo, i.e. @name, @props, @deprecated-props.  Can you tell me?
>>>>>
>>>>
>>>> Note: Compares ModelA and ModelB.
>>>>
>>>> Both @models must include @name.  @props is optional.  @deprecated-props
>>>> is ignored.
>>>>
>>>> @name: the name of the CPU model definition to look up.  The definition
>>>> will be compared against the generation, GA level, and a static set of
>>>> properties of the opposing model.
>>>>
>>>> @props: a set of additional properties to include in the model's set of
>>>> properties to be compared.
>>>>
>>>> @deprecated-props: ignored.  The user should consider these properties
>>>> beforehand and decide if these properties should be disabled/omitted on
>>>> the respective model.
>>>>
>>>>> * query-cpu-model-expansion argument @model and return value member
>>>>>    @model.
>>>>>
>>>>>    The other argument is the expansion type, on which the value of return
>>>>>    value model.deprecated-props depends, I believe.  Fine.
>>>>>
>>>>>    Documentation doesn't say how exactly the command uses the members of
>>>>>    CpuModelInfo arguments, i.e. @name, @props, @deprecated-props.  Can
>>>>>    you tell me?
>>>>>
>>>>
>>>> The @model must include @name.  @props is optional.  @deprecated-props
>>>> is ignored.
>>>>
>>>> @name: the name of the CPU model definition to look up.  The definition
>>>> is associated with a set of properties that will populate the return data.
>>>>
>>>> @props: a set of additional properties to include in the model's set of
>>>> expanded properties.
>>>>
>>>> @deprecated-props: ignored.  The user should consider these properties
>>>> beforehand and decide if these properties should be disabled/omitted on
>>>> the model.
>>>
>>> Return value member @model will have @name, may have @props and
>>> @deprecated-props.
>>>
>>> Absent @props is the same as {}.  Only x86 uses {}.
>>>
>>> Absent @deprecated-props is the same as {}.  No target uses {}.  Can be
>>> present only on S390.
>>>
>>> Aside: returning the same thing in two different ways, like absent and
>>> {}, is slightly more complex than necessary.  But let's ignore that
>>> here.
>>>
>>>>> * query-cpu-model-baseline both arguments and return value member
>>>>>    @model.
>>>>>
>>>>>    Same, except we don't have an expansion type here.  So same question,
>>>>>    plus another one: how does return value model.deprecated-props behave?
>>>>>
>>>>
>>>> Note: Creates a baseline model based on ModelA and ModelB.
>>>>
>>>> The @models must include @name.  @props is optional.  @deprecated-props
>>>> is ignored.
>>>>
>>>> @name: the name of the CPU model definition to look up.  The definition,
>>>> GA level, and a static set of properties will be used to determine the
>>>> maximum model between ModelA and ModelB.
>>>>
>>>> @props: a set of additional properties to include in the model's set of
>>>> properties to be baselined.
>>>>
>>>> @deprecated-props: ignored.  The user should consider these properties
>>>> beforehand and decide if these properties should be disabled/omitted on
>>>> the respective model.
>>>
>>> Return value member @model is just like in query-cpu-model-expansion.
>>>
>>> Unlike query-cpu-model-expansion, we don't have an expansion type.  The
>>> value of @deprecated-props depends on the expansion type.  Do we assume
>>> a type?  Which one?
>>>
>>>>> If you can't answer my questions, we need to find someone who can.
>>>>>
>>>>
>>>> Hopefully this provides clarity on how CpuModelInfo and its respective
>>>> fields are used in each command.  @David should be able to fill in any
>>>> missing areas / expand / offer corrections.
>>>>
>>>>> [...]
>>>
>>> This helps, thanks!
>>>
>>> Arguments that are silently ignored is bad interface design.
>>>
>>> Observe: when CpuModelInfo is an argument, @deprecated-props is always
>>> ignored.  When it's a return value, absent means {}, and it can be
>>> present only for certain targets (currently S390).
>>>
>>> The reason we end up with an argument we ignore is laziness: we use the
>>> same type for both roles.  We can fix that easily:
>>>
>>>      { 'struct': 'CpuModel',
>>>        'data': { 'name': 'str',
>>>                  '*props': 'any' } }
>>>
>>>      { 'struct': 'CpuModelInfo',
>>>        'base': 'CpuModel',
>>>        'data': { '*deprecated-props': ['str'] } }
>>>
>>> Use CpuModel for arguments, CpuModelInfo for return values.
>>>
>>> Since @deprecated-props is used only by some targets, I'd make it
>>> conditional, i.e. 'if': 'TARGET_S390X'.
>>
>> If we want just query-cpu-model-expansion return deprecated properties,
>> we can instead move @deprecated-props from CpuModelInfo to
>> CpuModelExpansionInfo.
> 
> That might a bit more sense, because deprecated-props does not make any 
> sense as input parameter, for example.
> 

Will do.  Thanks for the feedback.  v4 in the works.

-- 
Regards,
  Collin


